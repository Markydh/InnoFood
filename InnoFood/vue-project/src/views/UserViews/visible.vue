<script>
import * as echarts from 'echarts';

export default {
  name: "visible",
  data() {
    return {
      total: [],    // 储存订单数
      cnt: 0,
      totalMoney: 0,
      monthx: [],
      monthmoney: [],
    };
  },
  created() {
    this.userData = JSON.parse(localStorage.getItem('user')) || {};
    for (let i = 0; i < 4; i++) {  // 依次获取每个订单状态下的订单条数
      this.loadOrder(i);
    }
    this.loadMoney();
    this.loadMonthMoney();

  },
  mounted() {
  },
  methods: {
    loadOrder(i) {
      this.request.get('/order/count', {
        params: {
          userID: this.userData.userID,
          order_state: i
        }
      }).then(res => {
        // console.log(res)
        this.total[i] = res;    // 将订单条数存入total
        this.$forceUpdate(); // 更新
      });
    },
    loadMoney() {
      this.request.get('/order/money', {
        params: {
          userID: this.userData.userID,
        }
      }).then(res => {
        this.totalMoney = res;
        this.$forceUpdate(); // 更新
      });
    },
    // 获取每月花费总金额
    loadMonthMoney() {
      this.request.get('/order/monthmoney', {
        params: {
          userID: this.userData.userID,
        }
      }).then(res => {
            if (!res || !res.length) {
              console.error('未获取到有效的数据');
              return;
            }
            // console.log(res[0])

            for (let i = 0; i < res.length; i++) {
              this.monthx[i] = res[i].month1;
              this.monthmoney[i] = res[i].totalSpent;
              // this.$forceUpdate(); // 更新
            }
            console.log(this.monthx);
            console.log(this.monthmoney);
            this.diagram();
          }
      ).catch(error => {
        console.error('发生错误:', error);
      });
    },
    diagram() {
      // 柱状图: 每月花费money
      var chartDom = document.getElementById('main');
      var myChart = echarts.init(chartDom);

      var option = {
        color: ['#6a8bb6'], // 柱状图颜色
        xAxis: {
          name: '月份',
          type: 'category',
          data: this.monthx,
          axisLabel: {
            interval: 0, // 强制显示所有刻度标签
            rotate: 45, // 旋转刻度标签角度，使其更好看
          },
        },
        yAxis: {
          type: 'value',
          name: '消费/元',
        },
        series: [
          {
            data: this.monthmoney,
            type: 'bar',
            barWidth: '60%', // 调整柱状图宽度
            itemStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: '#b8c2db' }, // 渐变色起始颜色
                { offset: 1, color: '#6a8bb6' }, // 渐变色结束颜色
              ]),
              barBorderRadius: [5, 5, 0, 0], // 设置柱状图的圆角
            },
            emphasis: {
              focus: 'none', // 禁用视觉引导线
              itemStyle: {
                blur: 0,
                shadowBlur: 0,
              },
            },
            label: {
              show: true,
              position: 'top',
              color: '#222', // 设置标签文字颜色
            },
          },
        ],
        tooltip: {
          trigger: 'axis', // 设置触发类型为坐标轴触发
          axisPointer: {
            type: 'shadow',
          },
        },
      };

      myChart.setOption(option);
    },


    // 点击查看详情跳转订单页
    detail() {
      this.$router.push('/mine/orders');
    }
  },
}
</script>

<template>
  <div class="global">
    <div class="content">
      <!-- 卡片 -->
      <el-card class="custom-card completed-card">
        <div>
          <span class="card-title">已完成</span><br><br>
          <span class="card-value">{{ total[3] }} 条</span><br><br>
          <button type="button" @click="detail" class="action-button">查看详情</button>
        </div>
      </el-card>

      <el-card class="custom-card total-card">
        <div>
          <span class="card-title">总订单</span><br><br>
          <span class="card-value">{{ total[0] + total[1] + total[2] + total[3] }} 条</span><br><br>
          <button type="button" @click="detail" class="action-button">查看详情</button>
        </div>
      </el-card>

      <el-card class="custom-card total-expense-card">
        <div>
          <span class="card-title">总支出</span><br><br>
          <span class="card-value">{{ totalMoney }} 元</span><br><br>
        </div>
      </el-card>
    </div>

    <!-- 柱状图 -->
    <div id='main' class="chart"></div>
  </div>
</template>

<style scoped>
.content {
  display: flex;
  justify-content: space-around;
  margin-top: 1%;
}

.custom-card {
  border-radius: 15px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
  transition: box-shadow 0.3s, transform 0.3s;
  width: 30%;
  object-fit: cover;
  position: relative;
  overflow: hidden;
  border: 2px solid transparent;
  background-clip: padding-box;
}

.custom-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.3));
  z-index: 1;
}

.custom-card:hover {
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
  transform: scale(1.05);
  border: 2px solid rgba(255, 255, 255, 0.5);
}

.custom-card:hover::before {
  background: linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.5));
}

.completed-card {
  background: linear-gradient(to right, #3cba92, #4ae0a0);
}

.total-card {
  background: linear-gradient(to right, #6a8bb6, #b8c2db);
}

.total-expense-card {
  background: linear-gradient(to right, #9d7bb0, #d47fa6);
}

.action-button {
  background-color: #b8c2db;
  color: #fff;
  border: none;
  padding: 8px 16px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.action-button:hover {
  background-color: #6a8bb6;
}

.chart {
  height: 400px;
  width: 800px;
  background: rgba(255, 255, 255, 0.8);
  margin-top: 1%;
}
</style>


