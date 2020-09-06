import Vue from 'vue';
import Products from '../components/products.vue';

document.addEventListener('DOMContentLoaded', () => {
  const products = document.getElementById("products");
  const props = JSON.parse(products.dataset.props);

  new Vue({
    el: products,
    render: h => h(Products, { props: {
      products: props.products,
    }}),
  })
})
