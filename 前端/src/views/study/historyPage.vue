<script setup>
import { ref, onMounted } from 'vue'
import HeaderNav from '@/components/HeaderNav.vue'
import { getHistoryList } from '@/api/study'
import { padZero, getDateLine } from '@/utils/format'
import * as echarts from 'echarts'
import * as XLSX from 'xlsx'
import { storeToRefs } from 'pinia'
import { useUserStore } from '@/stores'
const userStore = useUserStore()
const { user } = storeToRefs(userStore)
const detail = {
  back: true,
  title: '学习历史'
}
const historyList = ref([])
const date = ref('')
const show = ref(false)
const minDate = new Date(2022, 0, 1)
const maxDate = new Date()
const formatDate = (date) =>
  `${date.getFullYear()}/${padZero(date.getMonth() + 1)}/${padZero(
    date.getDate()
  )}`
const onConfirm = (value) => {
  show.value = false
  if (value.length === 1) {
    date.value = formatDate(value[0])
  } else {
    date.value = `选择了${value.length}个日期`
  }
  const dateStr = value
    .map(
      (item) =>
        `${item.getFullYear()}-${padZero(item.getMonth() + 1)}-${padZero(
          item.getDate()
        )}`
    )
    .join(',')
  selectHistor(dateStr)
}
const activeNames = ref(['0'])
const selectHistor = async (dates) => {
  const res = await getHistoryList(dates)
  historyList.value = res.data.data
  initChart()
}
const getAllTime = (item) => {
  return item.reduce((sum, item) => (sum += item.time), 0)
}
onMounted(() => {
  selectHistor()
})
const initChart = () => {
  historyList.value.forEach((item, index) => {
    const interval = setInterval(() => {
      const chartElement = document.getElementById(`chart${index}`)
      if (chartElement) {
        const myChart = echarts.init(chartElement)
        const option = {
          xAxis: {
            type: 'category',
            data: item.record.map((target) => target.subject)
          },
          yAxis: {
            type: 'value'
          },
          grid: {
            top: '20%',
            left: '5%',
            right: '3.5%',
            height: '60%'
          },
          series: [
            {
              data: item.record.map((target) => target.time),
              type: 'bar'
            }
          ]
        }
        myChart.setOption(option)
        clearInterval(interval)
      }
    }, 500)
  })
}
const deriveExcel = () => {
  const exportArr = [['日期']]
  //动态补全Excel头部信息
  historyList.value.forEach((item) => {
    item.record.forEach((i) => {
      if (!exportArr[0].includes(i.subject)) {
        exportArr[0].push(i.subject)
      }
    })
  })
  //将每个日期的数据填充到信息对象中，并push到数组
  historyList.value.forEach((item) => {
    const itemArr = [...exportArr[0]]
    const date = new Date(item.date)
    itemArr[0] =
      date.getFullYear() +
      '/' +
      padZero(date.getMonth() + 1) +
      '/' +
      padZero(date.getDate())
    item.record.forEach((i) => {
      const index = itemArr.indexOf(i.subject)
      if (index !== -1) {
        itemArr[index] = i.time
      }
    })
    itemArr.forEach((i, index) => {
      exportArr[0].forEach((exi) => {
        if (i === exi) {
          itemArr[index] = null
        }
      })
    })
    exportArr.push(itemArr)
  })
  let workSheet = XLSX.utils.aoa_to_sheet(exportArr)
  let bookNew = XLSX.utils.book_new()
  XLSX.utils.book_append_sheet(bookNew, workSheet, '学习记录') // 工作簿名称
  const username = user.value.nickname || user.value.username
  let name = `${username}的学习记录.xlsx`
  XLSX.writeFile(bookNew, name) // 保存的文件名
}
</script>

<template>
  <HeaderNav :detail="detail">
    <template #right
      ><button
        style="border: none; background: transparent"
        @click="deriveExcel"
      >
        导出
      </button></template
    >
  </HeaderNav>
  <div class="history">
    <van-cell
      title="筛选"
      :value="date"
      @click="show = true"
      is-link
      style="border-radius: 8px"
    />
    <van-calendar
      v-model:show="show"
      type="multiple"
      @confirm="onConfirm"
      :min-date="minDate"
      :max-date="maxDate"
    />
    <div class="record">
      <div class="show" v-if="historyList.length > 0">
        <van-collapse v-model="activeNames">
          <van-collapse-item
            v-for="(item, index) in historyList"
            :key="item.date"
            :title="getDateLine(item.date)"
            :name="index"
            :value="getAllTime(item.record) + '分钟'"
          >
            <div :id="`chart${index}`" style="width: 100%; height: 200px"></div>
            <div class="content" v-for="target in item.record" :key="target.id">
              <div class="tag">{{ target.subject }}</div>
              <div class="time">{{ target.time }}分钟</div>
            </div>
          </van-collapse-item>
        </van-collapse>
        <div class="point">暂无更多记录</div>
      </div>
      <van-empty
        v-else
        image="https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/other/calendar.png"
        image-size="80"
        description="日期内无记录"
      />
    </div>
  </div>
</template>

<style scoped lang="scss">
.history {
  padding: 4px 8px;
  padding-top: 54px;
  .sift {
    padding: 10px 8px;
    background-color: #fff;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 14px;
    color: #444;
  }
  .record {
    margin-top: 12px;
    padding: 0 8px;
    border-radius: 8px;
    background-color: #fff;
    min-height: 40px;
    .point {
      height: 32px;
      line-height: 32px;
      font-size: 12px;
      color: #888;
      text-align: center;
    }
    .content {
      display: flex;
      justify-content: space-between;
      &:not(:first-child) {
        margin-top: 8px;
      }
    }
  }
}
</style>
