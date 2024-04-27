<template>
  <div class="compact-layout">
    <div class="chart-container">
      <!-- 配送员每月配送订单数变化 -->
      <el-card class="chart-card">
        <div slot="header" class="card-header">
          配送员每月配送订单数变化
        </div>
        <div id='monthlyOrdersDiagram' class="chart"></div>
      </el-card>

      <!-- 本月接单量 -->
      <el-card class="total-card" shadow="hover">
        <div slot="header" class="card-header">
          本月接单量
        </div>
        <div class="card-content">
          <p class="amount-text">已接 {{ totalOrders }} 单</p>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
import echarts from "echarts";

export default {
  name: "Home",
  data() {
    return {
      deliveryData: localStorage.getItem('delivery') ? JSON.parse(localStorage.getItem('delivery')) : {},
      orderMonth: [],
      monthlyOrders: [],
      totalOrders:0,
    }
  },
  created() {
    this.loadMonthlyOrders();
    this.loadTotalOrders();
  },
  methods: {
    // 获取配送员每月配送订单数
    loadMonthlyOrders() {
      this.request.get('/delivery/monthlyOrders', {
        params: {
          deliveryID: this.deliveryData.deliveryID,
        }
      }).then(res => {
        // console.log(res);
        for (let i = 0; i < res.length; i++) {
          this.orderMonth[i] = res[i].order_month;
          this.monthlyOrders[i] = res[i].monthly_order;
        }

        console.log(this.orderMonth);
        this.monthlyOrdersDiagram();

      });
    },
    monthlyOrdersDiagram() {
      var chartDom = document.getElementById('monthlyOrdersDiagram');
      var myChart = echarts.init(chartDom);

      var option = {
        xAxis: {
          type: 'category',
          data: this.orderMonth,
          axisLabel: {
            interval: 0, // 控制 x 轴标签的显示间隔
            rotate: 45, // 控制 x 轴标签的旋转角度
          },
        },
        yAxis: {
          type: 'value',
          name: '订单数',
        },
        series: [
          {
            data: this.monthlyOrders,
            type: 'line',
            symbol: 'circle', // 折线点设置为圆形
            symbolSize: 8, // 折线点的大小
            lineStyle: {
              width: 2, // 折线宽度
            },
            itemStyle: {
              color: '#6a8bb6', // 折线颜色
            },
          },
        ],
        grid: {
          top: '10%', // 控制图表距离容器上边界的距离
          left: '3%', // 控制图表距离容器左边界的距离
          right: '4%', // 控制图表距离容器右边界的距离
          bottom: '3%', // 控制图表距离容器下边界的距离
          containLabel: true,
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'line', // 直线指示器
            lineStyle: {
              color: '#6a8bb6',
              width: 2,
            },
          },
        },
      };

      option && myChart.setOption(option);
    },

    loadTotalOrders(){
      this.request.get('/delivery/monthlyPickOrder', {
        params: {
          deliveryID: this.deliveryData.deliveryID,
        }
      }).then(res => {
        this.totalOrders = res;
      });
    },
  }
}
</script>

<style scoped>
.compact-layout {
  padding: 20px;
}

.chart-container {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
}

.chart-card {
  width: calc(66.66% - 20px);
  margin-bottom: 20px;
}

.chart {
  height: 300px;
}

.total-card {
  width: calc(33.33% - 20px);
  background: linear-gradient(to bottom, #6a8bb6, #b8c2db);
  color: #fff;
  border: none;
  border-radius: 10px;
  overflow: hidden;
  transition: box-shadow 0.3s, transform 0.3s;
}

.total-card:hover {
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
  transform: scale(1.05);
}

.card-header {
  text-align: center;
  font-size: 18px;
  font-weight: bold;
  padding: 10px;
  border-radius: 10px 10px 0 0;
}

.card-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.amount-text {
  font-size: 24px;
  font-weight: bold;
  color: #fff;
}
</style>


