<template>
  <div>
    起始位置：<el-input id="start" v-model="startName" style="width: 200px"></el-input>
    结束位置：<el-input id="end" v-model="endName"  style="width: 200px"></el-input>
    <el-button @click="goView">查询</el-button>
    <div id="container" />
  </div>
</template>

<script>
import AMapLoader from '@amap/amap-jsapi-loader'

export default {
  name: 'AMapView',
  data() {
    return {
      map: null,
      startName: '',
      endName: ''
    }
  },
  mounted() {
    window._AMapSecurityConfig = {
      securityJsCode: '4b8c61a65e95f8ed41808ca7f2cccfe4' // 申请key对应的秘钥
    }
    // DOM初始化完成进行地图初始化
    this.initMap()
  },
  methods: {
    goView() {
      // eslint-disable-next-line no-undef
      const driving = new AMap.Driving({
        map: this.map,
        // 驾车路线规划策略，AMap.DrivingPolicy.LEAST_TIME是最快捷模式
        // eslint-disable-next-line no-undef
        policy: AMap.DrivingPolicy.LEAST_TIME
      })
      const points = [
        { keyword: this.startName, city: '全国' },
        { keyword: this.endName, city: '全国' }
      ]

      driving.search(points, (status, result) => {
        // 未出错时，result即是对应的路线规划方案
        console.log('status=', status)
        console.log('result=', result)
      })
    },
    initMap() {
      AMapLoader.load({
        key: 'e09feb4110a5273e0a1e8075c22e84f1', // 申请好的Web端开发者Key，首次调用 load 时必填
        version: '2.0', // 指定要加载的 JSAPI 的版本，缺省时默认为 1.4.15
        plugins: ['AMap.ToolBar', 'AMap.Driving', 'AMap.AutoComplete'] // 需要使用的的插件列表，如比例尺'AMap.Scale'等
      }).then(AMap => {
        this.map = new AMap.Map('container', { // 设置地图容器id
          viewMode: '3D', // 是否为3D地图模式
          zoom: 5, // 初始化地图级别
          center: [105.602725, 37.076636] // 初始化地图中心点位置
        })
        const autoOptions = {
          // city 限定城市，默认全国
          city: '全国',
          input: 'start'
        }
        // 实例化AutoComplete
        const autoComplete = new AMap.AutoComplete(autoOptions)
        const autoOptions2 = {
          // city 限定城市，默认全国
          city: '全国',
          input: 'end'
        }
        // 实例化AutoComplete
        const autoComplete2 = new AMap.AutoComplete(autoOptions2)
        // 根据关键字进行搜索
        /* autoComplete.search(this.startName, (status, result) => {
          // 搜索成功时，result即是对应的匹配数据
          console.log(result)
        }) */
      }).catch(e => {
        console.log(e)
      })
    }
  }
}
</script>
<style  scoped>

#container{
  padding:0px;
  margin: 0px;
  width: 100%;
  height: 800px;
}
#panel {
  position: fixed;
  background-color: white;
  max-height: 90%;
  overflow-y: auto;
  top: 10px;
  right: 10px;
  width: 280px;
}
#panel .amap-call {
  background-color: #009cf9;
  border-top-left-radius: 4px;
  border-top-right-radius: 4px;
}
#panel .amap-lib-driving {
  border-bottom-left-radius: 4px;
  border-bottom-right-radius: 4px;
  overflow: hidden;
}
</style>

