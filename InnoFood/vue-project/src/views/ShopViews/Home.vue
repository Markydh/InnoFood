<template>
  <div class="compact-layout">
    <div class="chart-container">
      <!-- 每个菜品的月销量占比-->
      <el-card class="chart-card">
        <div slot="header" class="card-header">
          每个菜品的月销量占比
        </div>
        <div id='monthlySalesDiagram' class="chart"></div>
      </el-card>
      <!-- 每个菜品类别的月销量占比-->
      <el-card class="chart-card">
        <div slot="header" class="card-header">
          每个菜品类别的月销量占比
        </div>
        <div id='categorySalesDiagram' class="chart"></div>
      </el-card>
      <!-- 本年每个月销售额变化-->
      <el-card class="chart-card">
        <div slot="header" class="card-header">
          本年每个月销售额变化
        </div>
        <div id='shopMonthlySalesDiagram' class="chart"></div>
      </el-card>
    </div>

    <el-card class="total-card" shadow="hover" style="border: none; border-radius: 10px; overflow: hidden;">
      <div slot="header" class="card-header">
        本月营业额
      </div>
      <div class="card-content">
        <p class="amount-text">当月营业额: {{ total_money }} 元</p>
      </div>
    </el-card>

  </div>
</template>


<script>
import * as echarts from "echarts";

export default {
  name: "Home",
  data() {
    return {
      shopData: localStorage.getItem('shop') ? JSON.parse(localStorage.getItem('shop')) : {}, //读取shop的数据，绑定店铺
      nameSales: [],
      category_nameSales: [],
      total_money: 0,
      shopMonthly: [],
      shopSales: [],
    }
  },
  created() {
    this.loadProductMonthlySales();
    this.loadCategorySales();
    this.loadShopTotalMoney();
    this.loadShopMonthlySales();
  },
  methods: {
    loadProductMonthlySales() {
      this.request.get('/shop/productMonthlySales', {
        params: {
          shopID: this.shopData.shopID,
        }
      }).then(res => {
        // console.log(res)
        for (let i = 0; i < res.length; i++) {
          this.nameSales[i] = {value: res[i].monthly_sales, name: res[i].product_name}
        }
        this.monthlySalesDiagram();
      })
    },

    loadCategorySales() {
      this.request.get('/shop/productCategorySales', {
        params: {
          shopID: this.shopData.shopID,
        }
      }).then(res => {
        // console.log(res)
        for (let i = 0; i < res.length; i++) {
          this.category_nameSales[i] = {value: res[i].category_sales, name: res[i].category_name}
        }
        // console.log(this.category_nameSales);
        this.categorySalesDiagram();

      })
    },

    loadShopTotalMoney() {
      this.request.get('/shop/shopTotalMoney', {
        params: {
          shopID: this.shopData.shopID,
        }
      }).then(res => {
        console.log(res)
        this.total_money = res
      })
    },

    monthlySalesDiagram() {
      var chartDom = document.getElementById('monthlySalesDiagram');
      var myChart = echarts.init(chartDom);

      var option = {
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b}: {c} ({d}%)',
        },
        legend: {
          type:'scroll',
          top: '5%',
          left: 'center',
          icon: 'circle',
        },
        series: [
          {
            name: '',
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            itemStyle: {
              borderRadius: 10,
              borderColor: 'white',
              borderWidth: 2,
            },
            label: {
              show: false,
              position: 'center',
            },
            emphasis: {
              label: {
                show: true,
                fontSize: 16,
                fontWeight: 'bold',
                smooth: true,
              },
            },
            labelLine: {
              show: false,
            },
            data: this.nameSales,
            animationType: 'scale', // 缩放动画
            animationEasing: 'elasticOut', // 弹性缓动效果
            animationDelay: function (idx) {
              return idx * 50; // 每个数据项之间的延迟
            },
          },
        ],
      };

      myChart.setOption(option);
    },

    categorySalesDiagram() {
      var chartDom = document.getElementById('categorySalesDiagram');
      var myChart = echarts.init(chartDom);

      var option = {
        tooltip: {
          trigger: 'item',
          formatter: '{a} <br/>{b}: {c} ({d}%)',
        },
        legend: {
          type:'scroll',
          top: '5%',
          left: 'center',
        },
        series: [
          {
            name: '',
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            itemStyle: {
              borderRadius: 10,
              borderColor: 'white',
              borderWidth: 2,
            },
            label: {
              show: false,
              position: 'center',
            },
            emphasis: {
              label: {
                show: true,
                fontSize: 16,
                fontWeight: 'bold',
                smooth: true,
              },
            },
            labelLine: {
              show: false,
            },
            data: this.category_nameSales,
            animationType: 'scale', // 缩放动画
            animationEasing: 'elasticOut', // 弹性缓动效果
            animationDelay: function (idx) {
              return idx * 50; // 每个数据项之间的延迟
            },
          },
        ],
      };

      myChart.setOption(option);
    },

    // 加载店铺本年每个月销售额
    loadShopMonthlySales() {
      this.request.get('/shop/shopMonthlySales', {
        params: {
          shopID: this.shopData.shopID,
        }
      }).then(res => {

        for (let i = 0; i < res.length; i++) {
          this.shopMonthly[i] = res[i].shop_month;
          this.shopSales[i] = res[i].shop_sales;
        }

        this.shopMonthlySalesDiagram();
      })
    },

    // 本年每个月销售额 折线图
    shopMonthlySalesDiagram() {
      var chartDom = document.getElementById('shopMonthlySalesDiagram');
      var myChart = echarts.init(chartDom);
      var option;

      option = {
        color: ['#6a8bb6'], // 折线颜色
        xAxis: {
          type: 'category',
          data: this.shopMonthly,
          axisLabel: {
            rotate: 45, // x轴标签旋转角度
            interval: 0, // 强制显示所有标签
            textStyle: {
              fontSize: 12 // x轴标签字体大小
            }
          },
          axisTick: {
            alignWithLabel: true // 刻度与标签对齐
          }
        },
        yAxis: {
          type: 'value',
          axisLabel: {
            textStyle: {
              fontSize: 12 // y轴标签字体大小
            }
          }
        },
        grid: {
          left: '5%', // 图表距离容器左边的距离
          right: '5%', // 图表距离容器右边的距离
          top: '10%', // 图表距离容器上边的距离
          bottom: '5%', // 图表距离容器下边的距离
          containLabel: true // 是否包含坐标轴的刻度标签
        },
        series: [
          {
            data: this.shopSales,
            type: 'line',
            smooth: true, // 平滑曲线
            symbol: 'circle', // 折线图中的标记图标类型
            symbolSize: 8, // 折线图中的标记图标大小
            lineStyle: {
              width: 2 // 折线宽度
            },
            itemStyle: {
              color: '#6a8bb6' // 折线标记的颜色
            }
          }
        ]
      };

      option && myChart.setOption(option);
    }


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

.chart-card {
  width: calc(33.33% - 20px);
  margin-bottom: 20px;
}

.chart {
  height: 300px;
}

.total-card {
  width: 100%;
  background: linear-gradient(to bottom, #fff, #fff);
  color: black;
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
  font-size: 20px;
  font-weight: bold;
  color: black;
}
</style>









