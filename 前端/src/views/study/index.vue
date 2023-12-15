<script name="study" setup>
import { ref, onMounted, nextTick, computed } from 'vue'
import * as echarts from 'echarts'
import HeaderNav from '@/components/HeaderNav.vue'
import { getRecord, getRecordWeek, getCharts } from '@/api/study.js'
import { useRouter } from 'vue-router'
import { dateDayFormat } from '@/utils/format.js'
const router = useRouter()
const detail = {
  title: '学习',
  back: false
}
const todayMap = ref()
const todayRecord = ref([])
const yesterdayTime = ref(0)
const initToday = () => {
  const todayChart = echarts.init(todayMap.value)
  var option = {
    tooltip: {
      trigger: 'item'
    },
    series: [
      {
        name: 'Access From',
        type: 'pie',
        radius: ['40%', '80%'],
        avoidLabelOverlap: false,
        itemStyle: {
          borderRadius: 2,
          borderColor: '#fff',
          borderWidth: 2
        },
        label: {
          show: false,
          position: 'center'
        },
        emphasis: {
          label: {
            show: true,
            fontSize: 10,
            fontWeight: 'bold'
          }
        },
        labelLine: {
          show: false
        },
        data: todayMapData()
      }
    ]
  }

  todayChart.setOption(option)
}
const getRecordList = async () => {
  const res = await getRecord()
  todayRecord.value = res.data.data.studies
  yesterdayTime.value = res.data.data.allHistoryTime
  nextTick(() => {
    if (todayRecord.value.length > 0) initToday()
  })
}
const todayMapData = () => {
  const firstFive = todayRecord.value.slice(0, 5)
  const remaining = todayRecord.value.slice(5)
  const output = []
  firstFive.map((item) =>
    output.push({
      value: item.time,
      name: item.subject
    })
  )
  let sum = 0
  if (remaining.length > 0) {
    sum = remaining.reduce((sum, item) => (sum += item.time), 0)
    output.push({
      value: sum,
      name: '其他'
    })
  }
  return output
}
const todayStudyTime = computed(() => {
  return todayRecord.value.reduce((sum, item) => {
    return sum + item.time
  }, 0)
})
const getTagColor = (index) => {
  switch (index) {
    case 0:
      return '#5470c6'
    case 1:
      return '#91cc75'
    case 2:
      return '#fac858'
    case 3:
      return '#ee6666'
    case 4:
      return '#73c0de'
    case 5:
      return '#3ba272'
  }
}
const getFrontFive = computed(() => {
  const firstFive = todayRecord.value.slice(0, 5)
  const remaining = todayRecord.value.slice(5)
  let output = []
  firstFive.forEach((item) => {
    output.push(item.subject)
  })
  if (remaining.length > 0) {
    output.push('其他')
  }
  return output.join('、')
})
const getCompareToDay = computed(() => {
  if (yesterdayTime.value === 0) {
    return '昨日未学习'
  }
  const percent = (
    (todayStudyTime.value - yesterdayTime.value) /
    yesterdayTime.value
  ).toFixed(2)
  if (percent > 0) return '+' + percent + '%'
  else return percent + '%'
})
const weekMap = ref()
const weekRecord = ref([])
const initWeek = () => {
  const weekChart = echarts.init(weekMap.value)
  var option = {
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: arrDate.value.reverse()
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
        data: weekRecord.value.map((item) => item.allHistoryTime).reverse(),
        type: 'line',
        areaStyle: {}
      }
    ]
  }
  weekChart.setOption(option)
}
const arrDate = ref([])
const getRecordWeekList = () => {
  getRecordWeek().then((res) => {
    weekRecord.value = res.data.data
    weekRecord.value.forEach((item) => {
      arrDate.value.push(dateDayFormat(item.date))
    })
    arrDate.value[0] = '今天'
    nextTick(() => {
      initWeek()
    })
  })
}
const charts = ref([])
const getDayCharts = () => {
  getCharts().then((res) => {
    charts.value = res.data.data
  })
}
onMounted(() => {
  getRecordList()
  getRecordWeekList()
  getDayCharts()
})

window.onresize = () => {
  nextTick(() => {
    if (todayRecord.value.length > 0) {
      initToday()
    }
    initWeek()
  })
}
</script>

<template>
  <HeaderNav :detail="detail"></HeaderNav>
  <div class="study">
    <div class="today" v-if="todayRecord.length > 0">
      <div class="info">
        <div ref="todayMap" style="width: 50%; height: 140px"></div>
        <div class="data">
          <div>
            <span class="key">今日已学习：</span>
            <span class="value">{{ todayStudyTime }}分钟</span>
          </div>
          <div>
            <span class="key">相比昨日：</span>
            <span class="value">{{ getCompareToDay }}</span>
          </div>
          <div>
            <span class="key">最多学习：</span>
            <span class="value">{{ getFrontFive }}</span>
          </div>
        </div>
      </div>
      <div class="mapInfo">
        <van-tag
          type="default"
          v-for="(item, index) in todayRecord"
          :key="item.id"
          :style="{ background: getTagColor(index) }"
          >{{ item.subject }}</van-tag
        >
      </div>
    </div>
    <div class="today" v-else>
      <van-empty image-size="60" description="今日还未进行学习" />
      <van-button
        type="default"
        round
        size="small"
        @click="router.replace('/home')"
        >前往首页</van-button
      >
    </div>
    <div class="menu">
      <van-button
        type="primary"
        size="large"
        style="
          margin-right: 4px;
          background: linear-gradient(45deg, #32c5ff, #1989fa);
        "
      >
        <div><i class="iconfont icon-shizhong"></i></div>
        <div style="margin-left: 10px">番茄钟</div>
      </van-button>
      <van-button
        type="success"
        size="large"
        style="
          margin-left: 4px;
          background: linear-gradient(45deg, #5ceda1, #07c160);
        "
      >
        <div style="position: relative; left: 6px">
          <i class="iconfont icon-shijian"></i>
        </div>
        <div style="margin-left: 10px">专注</div>
      </van-button>
      <van-button
        type="success"
        size="large"
        style="
          margin-left: 4px;
          background: linear-gradient(45deg, #998aff, #7655fe);
        "
        @click="router.push('/study/history')"
      >
        <div style="width: 58px">
          <div><i class="iconfont icon-shizhong"></i></div>
        </div>
        <div style="margin-left: 10px">学习历史</div>
      </van-button>
    </div>
    <div class="week">
      <div style="width: 100%; text-align: center; font-size: 14px">
        近7日学习
      </div>
      <div ref="weekMap" style="width: 100%; height: 200px"></div>
    </div>
    <div
      style="
        margin-left: 12px;
        font-weight: 600;
        margin-top: 16px;
        margin-bottom: 4px;
      "
    >
      每日排行
    </div>
    <div class="list">
      <ul v-if="charts.length > 0">
        <li>
          <div class="line">
            <div>排名</div>
            <div>信息</div>
            <div>时长</div>
          </div>
        </li>
        <li v-for="(item, index) in charts" :key="item.nickname">
          <div class="line">
            <div class="rank">{{ index + 1 }}</div>
            <div class="info">
              <img
                :src="item.avatar || '/src/assets/img/default-avatar.png'"
                alt=""
              />
              <div class="name text-ellipsis-1">{{ item.nickname }}</div>
            </div>
            <div class="time">{{ item.totalTime }}</div>
          </div>
        </li>
        <div class="point">仅展示前10名</div>
      </ul>
      <van-empty v-else image-size="60" description="排行榜还在准备中" />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.study {
  .today,
  .week,
  .list {
    background-color: #fff;
    padding: 10px 15px;
    margin: 4px 8px;
    border-radius: 8px;
  }

  .today {
    display: flex;
    flex-direction: column;
    .mapInfo {
      display: flex;
      justify-content: space-evenly;
    }
    .info {
      display: flex;
      .title {
        width: 100%;
        text-align: center;
        font-size: 16px;
      }

      .data {
        display: flex;
        flex-direction: column;
        justify-content: space-evenly;
        padding: 16px 8px;

        div {
          font-size: 14px;

          .key {
            font-weight: 600;
          }

          .value {
            font-weight: 400;
          }
        }
      }
    }
  }

  .menu {
    display: flex;
    margin: 8px;

    .van-button {
      height: 70px;
      border-radius: 12px;
      border: none;

      :deep(.van-button__content) {
        justify-content: flex-start;
      }
    }
  }

  .list {
    ul {
      li {
        margin: 8px 0;
        &:nth-child(1) {
          .line {
            justify-content: space-between;
          }
        }

        .line {
          display: flex;
          align-items: center;

          .rank {
            width: 40px;
            font-weight: 600;
          }

          .info {
            margin-left: 78px;
            display: flex;
            align-items: center;
            font-size: 15px;

            img {
              width: 30px;
              height: 30px;
              border-radius: 100%;
              margin-right: 4px;
            }
            .name {
              max-width: 65px;
              height: 30px;
              line-height: 32px;
            }
          }

          .time {
            flex: 1;
            text-align: right;
          }
        }
      }
      .point {
        font-size: 12px;
        color: #888;
        margin-top: 12px;
        text-align: center;
      }
    }
  }

  .iconfont {
    font-size: 30px;
  }
}
</style>
