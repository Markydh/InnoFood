<template>
  <div class="compact-layout">
    <div class="chart-container">
      <!-- 每个店铺的营业额占比 -->
      <el-card class="chart-card">
        <div slot="header" class="card-header">
          每个店铺的营业额占比
        </div>
        <div id="shopTotalDiagram" class="chart"></div>
      </el-card>

      <!-- 每个店铺的营业额 柱状图 -->
      <el-card class="chart-card">
        <div slot="header" class="card-header">
          每个店铺的营业额
        </div>
        <div id="everyShopSalesDiagram" class="chart"></div>
      </el-card>

      <!-- 每个店铺当月的订单数 柱状图-->
      <el-card class="chart-card">
        <div slot="header" class="card-header">
          每个店铺当月的订单数
        </div>
        <div id="shopOrdersDiagram" class="chart"></div>
      </el-card>
    </div>

    <!-- 所有店铺营业额 -->
    <el-card class="custom-card">
      <div class="card-content">
        <span class="card-title">所有店铺营业额</span><br>
        <span class="card-value">{{ totalMoney }}  元</span>
      </div>
    </el-card>
  </div>
</template>


<script>
import * as echarts from 'echarts';

export default {
  name: "ManagerVisual",
  data() {
    return {
      manager: localStorage.getItem('manager') ? JSON.parse(localStorage.getItem('manager')) : {},

      totalMoney: 0,

      namePrice: [],

      every_shopName: [],
      every_totalPrice: [],

      order_shopName:[],
      monthly_orders:[],
    }
  },
  methods: {
    loadMoney() {
      this.request.get('/manager/totalPrice', {
        params: {
          managerID: this.manager.managerID,
        }
      }).then(res => {
        this.totalMoney = res;
        // console.log(res)
      })
    },
    loadShopTotal() {
      this.request.get('/manager/shopTotal', {
        params: {
          managerID: this.manager.managerID,
        }
      }).then(res => {
        // console.log(res)
        for (let i = 0; i < res.length; i++) {
          this.namePrice[i] = {value: res[i].totalPrice, name: res[i].shopName};
          this.every_shopName[i] = res[i].shopName;
          this.every_totalPrice[i] = res[i].totalPrice;
        }
        this.shopTotalDiagram();
        this.everyShopSalesDiagram();
        console.log(this.namePrice);
      })
    },
    shopTotalDiagram() {
      var chartDom = document.getElementById('shopTotalDiagram');
      var myChart = echarts.init(chartDom);
      var option;

      option = {
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b}: {c} ({d}%)'
        },
        legend: {
          top: '5%',
          left: 'center'
        },
        series: [
          {
            name: '',
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            itemStyle: {
              borderRadius: 10,
              borderColor: null,
              borderWidth: 2
            },
            label: {
              show: false,
              position: 'center'
            },
            emphasis: {
              label: {
                show: true,
                fontSize: 40,
                fontWeight: 'bold',
                smooth: true
              }
            },
            labelLine: {
              show: false
            },
            data: this.namePrice
          }
        ]
      };

      option && myChart.setOption(option);

    },
    // 每个店铺的营业额 柱状图
    everyShopSalesDiagram() {
      var chartDom = document.getElementById('everyShopSalesDiagram');
      var myChart = echarts.init(chartDom);
      var option;

      option = {
        color: ['#3398DB'], // 柱状图颜色
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'shadow'        // 鼠标移动时的阴影样式
          }
        },
        grid: {
          left: '3%',
          right: '4%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'category',
          data: this.every_shopName,
          axisTick: {
            alignWithLabel: true
          },
          axisLabel: {
            rotate: 45, // 标签旋转角度
            interval: 0  // 强制显示所有标签
          }
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            data: this.every_totalPrice,
            type: 'bar',
            barWidth: '60%' // 柱状图宽度
          }
        ]
      };

      option && myChart.setOption(option);
    },

    // 获取每个店铺当月的订单数
    loadShopOrders() {
      this.request.get('/manager/shopOrders', {
        params: {
          managerID: this.manager.managerID,
        }
      }).then(res => {
        for (let i = 0; i < res.length; i++) {
          this.order_shopName[i] = res[i].order_shopName;
          this.monthly_orders[i] = res[i].monthly_orders;
        }
        this.shopOrdersDiagram();
      })
    },

    // 每个店铺当月的订单数 柱状图
    shopOrdersDiagram() {
      var chartDom = document.getElementById('shopOrdersDiagram');
      var myChart = echarts.init(chartDom);

      // 柱状图的颜色配置
      var colorPalette = ['#6a8bb6', '#b8c2db', '#4d7c8c', '#75a5b4', '#3cba92'];

      var option = {
        color: colorPalette,
        xAxis: {
          type: 'category',
          data: this.order_shopName,
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
            data: this.monthly_orders,
            type: 'bar',
            barWidth: '60%', // 控制柱状图的宽度
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
            type: 'shadow', // 阴影显示
          },
        },
      };

      option && myChart.setOption(option);
    }


  },
  created() {
    this.loadMoney();
    this.loadShopTotal();
    this.loadShopOrders();
  },
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

.custom-card,
.chart-card {
  width: calc(33.33% - 20px);
  margin-bottom: 20px;
  border-radius: 10px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
}

.custom-card {
  background: linear-gradient(to right, #4d7c8c, #75a5b4);
  transition: box-shadow 0.3s, transform 0.3s;
}

.custom-card:hover {
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
  transform: scale(1.05);
  border: 2px solid rgba(255, 255, 255, 0.5);
}

.custom-card .card-content,
.chart-card .chart {
  padding: 14px;
  flex: 1;
}

.card-title {
  font-size: 20px;
  font-weight: bold;
  color: #fff;
}

.card-value {
  font-size: 24px;
  font-weight: bold;
  color: #fff;
}

.chart-card {
  background: #fff;
}

.chart-card .chart {
  height: 300px;
}
</style>






