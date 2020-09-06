<template>
  <div>
    <h1>Create product with tags</h1>

    <table>
      <thead>
        <tr>
          <th>name</th>
          <th>description</th>
          <th>price</th>
          <th>tags</th>
          <th colspan="2">actions</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>
            <input v-model="newProduct.name" placeholder="name">
          </td>
          <td>
            <input v-model="newProduct.description" placeholder="description">
          </td>
          <td>
            <input v-model="newProduct.price" placeholder="price">
          </td>
          <td>
            <input class='tags'
            v-for="(tag, tagKey) in newProduct.tags.filter(t => t.title)"
            :key="tagKey"
            v-model="tag.title">
              <button @click="addRandTag">+</button>
            </input>
          </td>

          <td><button @click="add">add</button></td>
        </tr>
      </tbody>
    </table>

    <h1>Edit products</h1>

    <table>
      <thead>
        <tr>
          <th>id</th>
          <th>name</th>
          <th>description</th>
          <th>price</th>
          <th>tags</th>
          <th colspan="2">actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(product, key) in productList" :key="key">
          <td>{{ product.id }}</td>
          <td><input v-model="product.name"></input></td>
          <td><input v-model="product.description"></input></td>
          <td><input v-model="product.price"></input></td>
          <td>
            <input
            class='tags'
            v-for="(tag, tagKey) in product.tags.filter(t => t.title)"
            :key="tagKey"
            v-model="tag.title">
              <button @click="addTag(product)">+</button>
            </input>
          </td>
          <td><button @click="update(product)">update</button></td>
          <td><button @click="remove(product.id)">remove</button></td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    props: ['products'],
    data: (data) => {
      return {
        productList: data.products,
        newProduct: {
          name: Math.random().toString(36).substring(7),
          price: Math.random() * 10,
          description: Math.random().toString(36).substring(7),
          tags: [],
        },
      }
    },
    methods: {
      async add() {
        try {
          const params = {
            data: {
              type: 'product',
              id: 'undefined',
              attributes: {
                name: this.newProduct.name,
                description: this.newProduct.description,
                price: this.newProduct.price,
                tags: this.newProduct.tags.map(t => t.title).filter(Boolean),
              },
            },
          };

          const request = await this.addProduct(params);

          const result = request.data.data.attributes;
          result.id = request.data.data.id;

          this.productList.push(result);

          //FIXME just for development
          this.updateFields();

        } catch (e) {
          return ;
        }
      },

      async update(product) {
        try {
          const data = {
            data: {
              type: 'product',
              id: product.id,
              attributes: {
                name: product.name,
                description: product.description,
                price: product.price,
                tags: product.tags.map(t => t.title).filter(Boolean),
              },
            },
          };

          const path = `/api/v1/products/${product.id}`

          product.tags.filter(t => t.title)

          await axios({ method: 'PATCH', url: path, data });
        } catch (e) {
          console.log(e);
          return ;
        }
      },

      async remove(id) {
        try {
          const params = {
            data: {
              type: 'products',
              id: id,
              attributes: {},
            },
          };

          const request = await this.softDeleteProduct(params);

          this.productList = this.productList
            .filter(obj => {
              return obj.id != params.data.id
            });

        } catch (e) {
          return ;
        }
      },

      async addProduct(data) {
        return axios({
          method: 'POST',
          url: '/api/v1/products',
          data,
        });
      },

      async softDeleteProduct(data) {
        return axios({
          method: 'DELETE',
          url: `/api/v1/products/${data.data.id}`,
          data,
        });
      },

      async addTag(product) {
        product.tags.push({title: 'new tag'})
      },

      async addRandTag() {
        this.newProduct.tags.push({title: 'new tag'})
      },

      updateFields() {
        this.newProduct.name = Math.random().toString(36).substring(7);
        this.newProduct.description = Math.random().toString(36).substring(7);
        this.newProduct.price = Math.random() * 10;
      }
    },
  };
</script>

<style scoped>
  th, td {
    border: 1px solid black;
  }
  tr {
    padding: 15px;
  }
  input {
    border: none;
  }
  .tags{
    border: solid 1px;
  }
</style>
