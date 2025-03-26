<script setup>
import { useAsyncData } from 'nuxt/app'

// 定義請求函數，透過 API 取得用戶數據
const fetchUsers = async () => {
  console.log('Fetching data from API...')
  const response = await fetch('https://fake-json-api.mock.beeceptor.com/users')

  if (!response.ok) {
    throw new Error(`HTTP error! Status: ${response.status}`)
  }
  if (response.ok) {
    console.log(123);
  }

  return response.json()
}

// 使用 useAsyncData 請求數據
const { data: users, error, pending, refresh, status } = useAsyncData(
  'users', // key，確保 Nuxt 會幫我們快取這份資料
  fetchUsers,
  {
    lazy: false,  // 立即執行請求（預設 false，可省略）
    server: true, // 允許 SSR 執行（預設 true，可省略）
    default: () => [], // 設定初始值，避免 undefined
    transform: (data) => data.map(user => ({
      id: user.id,
      name: user.name.toUpperCase() // 轉換數據，這裡將名稱變大寫
    }))
  }
)

// 手動刷新數據的函數
const refreshData = () => {
  console.log('Manually refreshing data...')
  refresh()
}
</script>

<template>
  <div>
    <h1>Nuxt 3 Async Data Fetch Example</h1>
    
    <p v-if="pending">Loading users...</p>
    <p v-else-if="error">Error: {{ error.message }}</p>
    
    <div v-else>
      <h2>Fetched Users:</h2>
      <ul>
        <li v-for="user in users" :key="user.id">{{ user.name }}</li>
      </ul>
    </div>

    <p>Status: {{ status }}</p>
    <button @click="refreshData">Refresh Users</button>
  </div>
</template>

<style scoped>
h1 {
  color: #527dc3;
}
ul {
  list-style: none;
  padding: 0;
}
li {
  background-color: #f5f5f5;
  padding: 10px;
  margin: 5px 0;
  border-radius: 5px;
}
button {
  margin-top: 10px;
  padding: 10px 15px;
  background-color: #527dc3;
  color: white;
  border: none;
  cursor: pointer;
  border-radius: 5px;
}
button:hover {
  background-color: #4169b1;
}
</style>




<!-- <template>
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
</style> -->







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
