<template>
  <div>
    <h1>Welcome to Nuxt 3 with useAsyncData!</h1>
    <h2>Fetched Data:</h2>
    <pre>{{ posts }}</pre>

  </div>
</template>

<script setup>
import { useAsyncData } from 'nuxt/app';

const { data: posts, error, pending } = useAsyncData('posts', async () => {
  const response = await fetch('https://fake-json-api.mock.beeceptor.com/users');
  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }
  return await response.json();
});

</script>

<style scoped>
h1 {
  color: #527dc3;
}
pre {
  background-color: #f5f5f5;
  padding: 10px;
  border-radius: 5px;
}
</style>







<!-- <template>
  <div>
    <h1>Nuxt 3 SSR Example</h1>
    <p>這是一個伺服器端渲染的頁面。</p>
    <p>API 資料：{{ data }}</p>
  </div>
</template>

<script setup>
const { data } = await useFetch('/api/hello')
</script> -->
