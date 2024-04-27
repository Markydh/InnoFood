<!--此界面目的是-->
<!--技术：利用ECharts -->
<!--目的：从数据库获取商品信息通过折线图的形式展示在界面上，可视化-->


<template>
  <div>
    <!-- 给图表一个容器，设置宽高 -->
    <div ref="lineChart" style="width: 600px; height: 400px;"></div>
  </div>
</template>

<script>
// 引入 ECharts
import echarts from 'echarts';

export default {
  name: 'diagram',
  data() {
    return {
      // 数据
      chartData: {
        categories: [],
        data: []
      }
    };
  },
  mounted() {
      this.getData();
  },
  methods: {
    getData(){
          this.request.get('/product').then(response => {
              console.log('fetching data:', response);
              // 将 JSON 数据转化为对象列表
              const productList = response.map(item => ({
                productname: item.productname,
                sales: item.sales,
              }));
              // 将对象列表的属性映射到图表所需的格式
              this.chartData.categories = productList.map(product => product.productname);
              this.chartData.data = productList.map(product => product.sales);
              this.initLineChart();
            })
            .catch(error => {
              console.error('Error fetching data:', error);
            });
    },
    // 初始化折线图
    initLineChart() {
      // 基于准备好的dom，初始化echarts实例
      const myChart = echarts.init(this.$refs.lineChart);

      // 指定图表的配置项和数据
      const option = {
        title: {
          text: '折线图示例'
        },
        xAxis: {
          type: 'category',
          data: this.chartData.categories
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            name: '销量',
            type: 'line',
            data: this.chartData.data
          }
        ],
        tooltip: {
          trigger: 'axis', // 触发类型，axis 表示坐标轴触发
          axisPointer: {
            type:'cross',
            handle: {
              show: true,
              size: 40, // 设置悬浮窗的大小
            }
          },
          extraCssText: 'width: 200px; height: 100px; text-align: center; line-height: 3;', // 设置悬浮窗的大小,以及文本的水平垂直居中
          backgroundColor:'#2cfdca',
          textStyle:{
            color:'#ea5d88',
            fontsize:12
          },
          formatter: function (params) {
            // 在这里可以自定义 tooltip 的显示内容
            const dataIndex = params[0].dataIndex;
            const productname = params[0].name;
            const sales = params[0].value;
            return `产品名称：${productname}<br>销量：${sales}`;
          },
        }
      };
      // 使用刚指定的配置项和数据显示图表。
      myChart.setOption(option);
    }
  }
};
</script>

<style scoped>
/* 样式可以根据需要进行调整 */
</style>
