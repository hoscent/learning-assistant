import { createRouter, createWebHistory } from 'vue-router'
import { showToast } from 'vant'
import 'vant/es/toast/style'
import { useUserStore } from '@/stores'

import Layout from '@/views/layout/index.vue'
import Home from '@/views/layout/home.vue'
import Study from '@/views/study/index.vue'
import Community from '@/views/community/index.vue'
import Publish from '@/views/community/publishArticle.vue'
import User from '@/views/user/index.vue'
import Chat from '@/views/index/chatPage.vue'
const Login = () => import('@/views/user/loginPage.vue')
const Detail = () => import('@/views/index/detailPage.vue')

const StudyHistory = () => import('@/views/study/historyPage.vue')

const News = () => import('@/views/community/newsPage.vue')
const Article = () => import('@/views/community/articleDetail.vue')

const Setting = () => import('@/views/user/settingPage.vue')
const UserInfo = () => import('@/views/user/userInfo.vue')

const Search = () => import('@/views/search/index.vue')

const Notebook = () => import('@/views/notebook/index.vue')
const NotesEdit = () => import('@/views/notebook/editNotebook.vue')

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      component: Layout,
      children: [
        { name: 'home', path: '/home', component: Home },
        { name: 'study', path: '/study', component: Study },
        { name: 'community', path: '/community', component: Community },
        { name: 'user', path: '/user', component: User }
      ],
      redirect: '/home'
    },
    {
      path: '/login',
      component: Login
    },
    {
      path: '/search',
      component: Search
    },
    {
      path: '/study/history',
      component: StudyHistory
    },
    {
      path: '/community/news',
      component: News
    },
    {
      path: '/home/detail',
      component: Detail
    },
    {
      path: '/home/chat',
      component: Chat
    },
    {
      path: '/community/article',
      component: Article
    },
    {
      path: '/community/publish',
      component: Publish
    },
    {
      path: '/user/setting',
      component: Setting
    },
    {
      path: '/user/info',
      component: UserInfo
    },
    {
      path: '/user/notebook',
      component: Notebook
    },
    {
      path: '/user/notebook/edit',
      component: NotesEdit
    }
  ]
})

router.beforeEach((to, from) => {
  const userStore = useUserStore()
  if (!userStore.token && to.path !== '/login') {
    showToast('请先登录')
    return '/login'
  }
  if (to.path === '/login' && userStore.token) {
    userStore.verifyTokenLegal().then((res) => {
      if (res) {
        showToast('您已登录')
        return from.path
      }
    })
  }
  if (userStore.token) {
    userStore.verifyTokenLegal().then((res) => {
      if (res) {
        userStore.getUser()
      } else {
        showToast('登录过期')
        userStore.clearUser()
        router.replace('/login')
      }
    })
  }
  return true
})

export default router
