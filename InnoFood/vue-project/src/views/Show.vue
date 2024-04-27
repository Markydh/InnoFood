<template>
  <div id="container" style="width:100vw;height:90vh" />
</template>

<script>

import AMapLoader from "@amap/amap-jsapi-loader"; //引用标注图标
//绘制线路需要的坐标
var lineArr = [[116.478935, 39.997761], [116.478939, 39.997825], [116.478912, 39.998549], [116.478912, 39.998549], [116.478998, 39.998555], [116.478998, 39.998555], [116.479282, 39.99856], [116.479658, 39.998528], [116.480151, 39.998453], [116.480784, 39.998302], [116.480784, 39.998302], [116.481149, 39.998184], [116.481573, 39.997997], [116.481863, 39.997846], [116.482072, 39.997718], [116.482362, 39.997718], [116.483633, 39.998935], [116.48367, 39.998968], [108.983569, 34.285675], [106.205794, 38.458831], [111.761777, 40.875595], [103.85094, 35.987496]]
export default {
  data() {
    return {
      firstArr: [116.478935, 39.997761] //中心点/初始坐标
    }
  },
  created() {},
  mounted() {
    setTimeout(() => {
      this.initMap() //异步加载（否则报错initMap is not defined）
      // this.initroad()
    }, 1000)
  },

  methods: {
    // 初始化地图
    initMap() {
      var that = this
      AMapLoader.load({
        key: 'b91495ad457595c5faa69a032ded8c0a', // 申请好的Web端开发者Key，首次调用 load 时必填
        version: '2.0', // 指定要加载的 JSAPI 的版本，缺省时默认为 1.4.15
        plugins: ['AMap.ToolBar', 'AMap.Driving', 'AMap.AutoComplete'] // 需要使用的的插件列表，如比例尺'AMap.Scale'等
      }).then(AMap => {
        this.map = new AMap.Map('container', {
          resizeEnable: true, // 窗口大小调整
          center: this.firstArr, // 中心 firstArr: [116.478935, 39.997761],
          zoom: 5
        })
        // 添加工具栏
        this.map.plugin(['AMap.ToolBar', 'AMap.Scale'], () => {
          // 工具条
          const toolbar = new AMap.ToolBar()
          // 比例尺
          const scale = new AMap.Scale()
          this.map.addControl(toolbar)
          this.map.addControl(scale)
        })
        // 添加maker
        this.marker = new AMap.Marker({
          map: this.map,
          position: this.firstArr,
          icon: 'https://webapi.amap.com/images/car.png',
          offset: new AMap.Pixel(-26, -13), // 调整图片偏移
          autoRotation: true, // 自动旋转
          angle: -90 // 图片旋转角度
        })
        // maker点击事件
        this.marker.on('click', function (e) {
          console.log(`我被点击啦---`, e)
          that.initroad() //点击maker绘制轨迹
          setTimeout(() => {
            this.moveAlong(lineArr, 1000000) // 动态描点(需要二次动态绘制轨迹开启)
          }, 500)
        })
      })
    },
    moveAlong(path, duration) {
      this.marker.moveAlong(path, duration);
    },
    // 初始化轨迹
    initroad() {
      // 绘制还未经过的路线
      this.polyline = new AMap.Polyline({
        map: this.map,
        path: lineArr,
        showDir: true,
        strokeColor: '#28F', // 线颜色--蓝色
        // strokeOpacity: 1,     //线透明度
        strokeWeight: 6, // 线宽
        // strokeStyle: "solid"  //线样式
        lineJoin: 'round' // 折线拐点的绘制样式
      })
      // 绘制路过了的轨迹
      var passedPolyline = new AMap.Polyline({
        map: this.map,
        strokeColor: '#AF5', // 线颜色-绿色
        // path: lineArr.reverse(),
        // strokeOpacity: 1,     //线透明度
        strokeWeight: 6 // 线宽
        // strokeStyle: "solid"  //线样式
      })
      this.marker.on('moving', e => {
        passedPolyline.setPath(e.passedPath)
      })
      this.map.setFitView() // 合适的视口
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
