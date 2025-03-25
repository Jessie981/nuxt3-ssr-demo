<template>
  <div>
    <h1>Nuxt 3 SSR Example</h1>
    <p>這是一個伺服器端渲染的頁面。</p>
    <p>API 資料：{{ data }}</p>
  </div>
</template>

<script setup>
const { data } = await useFetch('/api/hello')
</script>
