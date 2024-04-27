<template>
  <div>
    <el-button @click="goView('fastest')">最快捷路线</el-button>
    <el-button @click="goView('shortest')">最短路线</el-button>
    <el-button @click="goView('leastPay')">最经济路线</el-button>
    <el-button @click="goView('goodTraffic')">路口良好路线</el-button>
    <div id="panel"></div>
    <div id="container" />
  </div>
</template>

<script>
import AMapLoader from '@amap/amap-jsapi-loader'

export default {
  name: 'RoadInfo',

  data() {
    return {
      map: null,
      driving:null,
      shopAddress:'',
      userAddress:'',
      newAddress:localStorage.getItem('address')?JSON.parse(localStorage.getItem('address')):{},
    }
  },
  mounted() {
    window._AMapSecurityConfig = {
      securityJsCode: 'f46d606f645c8a40d32a2c1ce80b900c' // 申请key对应的秘钥
    }
    // DOM初始化完成进行地图初始化
    this.initMap()
    this.goView();
  },
  methods: {
    //初始化地图
    initMap() {
      AMapLoader.load({
        key: '7260bee5d50f6486d2aeae7a874f3339', // 申请好的Web端开发者Key，首次调用 load 时必填
        version: '2.0', // 指定要加载的 JSAPI 的版本，缺省时默认为 1.4.15
        plugins: ['AMap.ToolBar', 'AMap.Driving', 'AMap.AutoComplete'] // 需要使用的的插件列表，如比例尺'AMap.Scale'等
      }).then(AMap => {
        this.map = new AMap.Map('container', { // 设置地图容器id
          viewMode: '3D', // 是否为3D地图模式
          zoom: 12, // 初始化地图级别
          center: [115.9044098854065,28.674106639382938] // 初始化地图中心点位置
        })
        const autoOptions = {
          // city 限定城市，默认全国
          city: '南昌',
          input: 'start'
        }
        // 实例化AutoComplete
        const autoComplete = new AMap.AutoComplete(autoOptions)
        const autoOptions2 = {
          // city 限定城市，默认全国
          city: '南昌',
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
    },
    goView(type) {
      this.shopAddress = this.newAddress.shopAddress;
      this.userAddress = this.newAddress.userAddress;
      if (type === 'fastest') {
        this.driving = new window.AMap.Driving({
          map: this.map,
          showTraffic: true,
          panel: 'panel',
          policy: window.AMap.DrivingPolicy.LEAST_TIME
        });
      } else if (type === 'shortest') {
        this.driving = new window.AMap.Driving({
          map: this.map,
          showTraffic: true,
          panel: 'panel',
          policy: window.AMap.DrivingPolicy.LEAST_DISTANCE
        });
      } else if (type === 'leastPay') {
        this.driving = new window.AMap.Driving({
          map: this.map,
          panel: 'panel',
          showTraffic: true,
          policy: window.AMap.DrivingPolicy.LEAST_FEE
        });
      } else if (type === 'goodTraffic') {
        this.driving = new window.AMap.Driving({
          showTraffic: true,
          map: this.map,
          panel: 'panel',
          policy: window.AMap.DrivingPolicy.REAL_TRAFFIC
        });
      }

      if (this.driving) { // 确保 this.driving 不为 null
        const points = [
          { keyword: this.shopAddress, city: '南昌' },
          { keyword: this.userAddress, city: '南昌' }
        ];

        this.driving.search(points, (status, result) => {
          console.log('status=', status);
          console.log('result=', result);

          this.map.setFitView();
        });
      } else {
        console.error('this.driving is null. Failed to execute search.');
      }
    },

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
  left: 10px;
  width: 220px;
  z-index:100;
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



<!--function1-->
<!--<template>-->
<!--  <div>-->
<!--    <el-button @click="goView('fastest')">最快捷路线</el-button>-->
<!--    <el-button @click="goView('shortest')">最短路线</el-button>-->
<!--    <el-button @click="goView('leastPay')">最经济路线</el-button>-->
<!--    <el-button @click="goView('goodTraffic')">路口良好路线</el-button>-->
<!--    <div id="panel"></div>-->
<!--    <div id="container"></div>-->
<!--  </div>-->
<!--</template>-->

<!--<script>-->
<!--import AMapLoader from '@amap/amap-jsapi-loader';-->

<!--export default {-->
<!--  name: 'RoadInfo',-->

<!--  data() {-->
<!--    return {-->
<!--      map: null,-->
<!--      shopAddress: '',-->
<!--      userAddress: '',-->
<!--      newAddress: localStorage.getItem('address') ? JSON.parse(localStorage.getItem('address')) : {},-->
<!--      pathSimplifierIns: null,-->
<!--      driving: null,-->
<!--    };-->
<!--  },-->

<!--  mounted() {-->
<!--    window._AMapSecurityConfig = {-->
<!--      securityJsCode: 'f46d606f645c8a40d32a2c1ce80b900c',-->
<!--    };-->
<!--    // DOM初始化完成进行地图初始化-->
<!--    this.initMap();-->
<!--  },-->

<!--  methods: {-->
<!--    goView(type) {-->
<!--      this.shopAddress = this.newAddress.shopAddress;-->
<!--      this.userAddress = this.newAddress.userAddress;-->

<!--      if (!this.driving) {-->
<!--        this.initDriving();-->
<!--      }-->

<!--      // 根据不同情况进行路线规划-->
<!--      this.driving.search(-->
<!--          [-->
<!--            { keyword: this.shopAddress, city: '南昌' },-->
<!--            { keyword: this.userAddress, city: '南昌' },-->
<!--          ],-->
<!--          {-->
<!--            policy:-->
<!--                type === 'fastest'-->
<!--                    ? AMap.DrivingPolicy.LEAST_TIME-->
<!--                    : type === 'shortest'-->
<!--                        ? AMap.DrivingPolicy.LEAST_DISTANCE-->
<!--                        : type === 'leastPay'-->
<!--                            ? AMap.DrivingPolicy.LEAST_FEE-->
<!--                            : AMap.DrivingPolicy.REAL_TRAFFIC,-->
<!--          }-->
<!--      );-->
<!--    },-->

<!--    //初始化地图-->
<!--    initMap() {-->
<!--      AMapLoader.load({-->
<!--        key: '7260bee5d50f6486d2aeae7a874f3339',-->
<!--        version: '2.0',-->
<!--        plugins: ['AMap.ToolBar', 'AMap.Driving', 'AMap.PathSimplifier'],-->
<!--      }).then((AMap) => {-->
<!--        this.map = new AMap.Map('container', {-->
<!--          viewMode: '3D',-->
<!--          zoom: 12,-->
<!--          center: [115.9044098854065, 28.674106639382938],-->
<!--        });-->

<!--        this.initDriving(); // Initialize the driving instance-->

<!--        AMapUI.load(['ui/misc/PathSimplifier', 'lib/$'], (PathSimplifier, $) => {-->
<!--          if (!PathSimplifier.supportCanvas) {-->
<!--            alert('当前环境不支持 Canvas！');-->
<!--            return;-->
<!--          }-->
<!--          this.initPathSimplifier(PathSimplifier, $);-->
<!--        });-->
<!--      });-->
<!--    },-->

<!--    initDriving() {-->
<!--      AMap.plugin('AMap.Driving', () => {-->
<!--        this.driving = new AMap.Driving({-->
<!--          map: this.map,-->
<!--          panel: 'panel',-->
<!--        });-->
<!--        AMap.event.addListener(this.driving, 'complete', (data) => {-->
<!--          if (data.routes && data.routes.length) {-->
<!--            const path = data.routes[0].path;-->
<!--            this.showPathSimplifier(path);-->
<!--          }-->
<!--        });-->
<!--      });-->
<!--    },-->

<!--    initPathSimplifier(PathSimplifier, $) {-->
<!--      if (!PathSimplifier.supportCanvas) {-->
<!--        alert('当前环境不支持 Canvas！');-->
<!--        return;-->
<!--      }-->

<!--      this.pathSimplifierIns = new PathSimplifier({-->
<!--        zIndex: 100,-->
<!--        map: this.map,-->
<!--        getPath: (pathData, pathIndex) => {-->
<!--          return pathData.path;-->
<!--        },-->
<!--        getHoverTitle: (pathData, pathIndex, pointIndex) => {-->
<!--          if (pointIndex >= 0) {-->
<!--            // 鼠标悬停在某个轨迹点上-->
<!--            return pathData.name + '，点:' + pointIndex + '/' + pathData.path.length;-->
<!--          }-->
<!--          // 鼠标悬停在线或者区域上-->
<!--          return pathData.name + '，点数量' + pathData.path.length;-->
<!--        },-->
<!--        renderOptions: {-->
<!--          pathLineStyle: {-->
<!--            lineWidth: 6,-->
<!--            dirArrowStyle: true,-->
<!--          },-->
<!--          autoSetFitView: true, // 自动调整地图视图以适应整个路径-->
<!--          duration: 1000, // 动画持续时间（毫秒）-->
<!--        },-->
<!--      });-->

<!--      this.pathSimplifierIns.setData([{-->
<!--        name: '轨迹',-->
<!--        path: [], // 起始时为空-->
<!--      }]);-->

<!--      this.pathSimplifierIns.on('pathClick', (e, info) => {-->
<!--        // 点击轨迹上的某个点时触发-->
<!--        const pathData = this.pathSimplifierIns.getData()[0];-->
<!--        const pathIndex = info.pathIndex;-->
<!--        const pointIndex = info.pointIndex;-->

<!--        if (pointIndex >= 0) {-->
<!--          // 点击轨迹点-->
<!--          console.log('点击了轨迹点', pathIndex, pointIndex, pathData.path[pointIndex]);-->
<!--        } else {-->
<!--          // 点击轨迹线-->
<!--          console.log('点击了轨迹线', pathIndex);-->
<!--        }-->
<!--      });-->

<!--      this.pathSimplifierIns.on('pathMouseover', (e, info) => {-->
<!--        // 鼠标悬停在轨迹上的某个点时触发-->
<!--        const pathData = this.pathSimplifierIns.getData()[0];-->
<!--        const pathIndex = info.pathIndex;-->
<!--        const pointIndex = info.pointIndex;-->

<!--        if (pointIndex >= 0) {-->
<!--          // 鼠标悬停在轨迹点-->
<!--          console.log('鼠标悬停在轨迹点', pathIndex, pointIndex, pathData.path[pointIndex]);-->
<!--        } else {-->
<!--          // 鼠标悬停在轨迹线-->
<!--          console.log('鼠标悬停在轨迹线', pathIndex);-->
<!--        }-->
<!--      });-->

<!--      this.pathSimplifierIns.on('pathMouseout', (e, info) => {-->
<!--        // 鼠标离开轨迹时触发-->
<!--        console.log('鼠标离开轨迹');-->
<!--      });-->
<!--    },-->

<!--    showPathSimplifier(path) {-->
<!--      if (this.pathSimplifierIns) {-->
<!--        const data = this.pathSimplifierIns.getData()[0];-->
<!--        data.path = path;-->
<!--        this.pathSimplifierIns.setData([data]);-->
<!--        this.pathSimplifierIns.renderLater();-->
<!--        this.pathSimplifierIns.showPath(0, 0); // 显示轨迹-->
<!--      }-->
<!--    },-->
<!--  },-->
<!--};-->
<!--</script>-->

<!--<style scoped>-->
<!--#container {-->
<!--  padding: 0;-->
<!--  margin: 0;-->
<!--  width: 100%;-->
<!--  height: 800px;-->
<!--}-->
<!--#panel {-->
<!--  position: fixed;-->
<!--  background-color: white;-->
<!--  max-height: 90%;-->
<!--  overflow-y: auto;-->
<!--  top: 10px;-->
<!--  left: 10px;-->
<!--  width: 220px;-->
<!--  z-index:100;-->
<!--}-->
<!--#panel .amap-call {-->
<!--  background-color: #009cf9;-->
<!--  border-top-left-radius: 4px;-->
<!--  border-top-right-radius: 4px;-->
<!--}-->
<!--#panel .amap-lib-driving {-->
<!--  border-bottom-left-radius: 4px;-->
<!--  border-bottom-right-radius: 4px;-->
<!--  overflow: hidden;-->
<!--}-->
<!--</style>-->






<!--function2-->
<!--<template>-->
<!--  <div>-->
<!--    <el-button @click="goView('fastest')">最快捷路线</el-button>-->
<!--    <el-button @click="goView('shortest')">最短路线</el-button>-->
<!--    <el-button @click="goView('leastPay')">最经济路线</el-button>-->
<!--    <el-button @click="goView('goodTraffic')">路口良好路线</el-button>-->
<!--    <div id="panel"></div>-->
<!--    <div id="container"></div>-->
<!--  </div>-->
<!--</template>-->

<!--<script>-->
<!--import AMapLoader from '@amap/amap-jsapi-loader';-->

<!--export default {-->
<!--  name: 'RoadInfo',-->

<!--  data() {-->
<!--    return {-->
<!--      map: null,-->
<!--      shopAddress: '',-->
<!--      userAddress: '',-->
<!--      newAddress: localStorage.getItem('address') ? JSON.parse(localStorage.getItem('address')) : {},-->
<!--      pathSimplifierIns: null,-->
<!--      driving: null,-->
<!--    };-->
<!--  },-->

<!--  mounted() {-->
<!--    window._AMapSecurityConfig = {-->
<!--      securityJsCode: 'f46d606f645c8a40d32a2c1ce80b900c',-->
<!--    };-->
<!--    // DOM初始化完成进行地图初始化-->
<!--    this.initMap();-->
<!--  },-->

<!--  methods: {-->
<!--    goView(type) {-->
<!--      this.shopAddress = this.newAddress.shopAddress;-->
<!--      this.userAddress = this.newAddress.userAddress;-->

<!--      if (!this.driving) {-->
<!--        this.initDriving();-->
<!--      }-->

<!--      // 根据不同情况进行路线规划-->
<!--      this.driving.search(-->
<!--          [-->
<!--            {keyword: this.shopAddress, city: '南昌'},-->
<!--            {keyword: this.userAddress, city: '南昌'},-->
<!--          ],-->
<!--          {-->
<!--            policy:-->
<!--                type === 'fastest'-->
<!--                    ? AMap.DrivingPolicy.LEAST_TIME-->
<!--                    : type === 'shortest'-->
<!--                        ? AMap.DrivingPolicy.LEAST_DISTANCE-->
<!--                        : type === 'leastPay'-->
<!--                            ? AMap.DrivingPolicy.LEAST_FEE-->
<!--                            : AMap.DrivingPolicy.REAL_TRAFFIC,-->
<!--          }-->
<!--      );-->
<!--    },-->

<!--    initMap() {-->
<!--      AMapLoader.load({-->
<!--        key: '7260bee5d50f6486d2aeae7a874f3339',-->
<!--        version: '2.0',-->
<!--        plugins: ['AMap.ToolBar', 'AMap.Driving', 'AMap.PathSimplifier'],-->
<!--      }).then((AMap) => {-->
<!--        this.map = new AMap.Map('container', {-->
<!--          viewMode: '3D',-->
<!--          zoom: 12,-->
<!--          center: [115.9044098854065, 28.674106639382938],-->
<!--        });-->
<!--        this.initDriving(); // Initialize the driving instance-->
<!--      });-->
<!--    },-->

<!--    initDriving() {-->
<!--      AMap.plugin('AMap.Driving', () => {-->
<!--        this.driving = new AMap.Driving({-->
<!--          map: this.map,-->
<!--          panel: 'panel',-->
<!--        });-->

<!--        // 获取路径信息-->
<!--        const path = this.driving.getResults().routes[0].path;-->
<!--        this.renderPath(path);-->
<!--        AMap.event.addListener(this.driving, 'complete', (data) => {-->
<!--          if (data.routes && data.routes.length) {-->
<!--            const path = data.routes[0].path;-->
<!--            this.showPathSimplifier(path);-->
<!--          }-->
<!--        });-->
<!--      });-->
<!--    },-->

<!--    renderPath(d) {-->
<!--      var that = this;-->
<!--      AMapUI.load(['ui/misc/PathSimplifier', 'lib/$'], function (PathSimplifier, $) {-->
<!--        window.pathSimplifierIns && window.pathSimplifierIns.setData([]); // 切换时先重置轨迹数据重新渲染-->
<!--        if (!PathSimplifier.supportCanvas) {-->
<!--          alert('当前环境不支持 Canvas！');-->
<!--          return;-->
<!--        }-->

<!--        var pathSimplifierIns = new PathSimplifier({-->
<!--          zIndex: 100,-->
<!--          map: that.map, // 所属的地图实例-->
<!--          getPath: function (pathData, pathIndex) {-->
<!--            return pathData.path;-->
<!--          },-->
<!--          renderOptions: {-->
<!--            keyPointTolerance: 40,-->
<!--            pathLineStyle: {-->
<!--              dirArrowStyle: true,-->
<!--            },-->
<!--            getPathStyle: function (pathItem, zoom) {-->
<!--              return {-->
<!--                pathLineStyle: {-->
<!--                  strokeStyle: 'rgba(0,0,0,0)',-->
<!--                  borderWidth: 0,-->
<!--                  lineWidth: 0,-->
<!--                },-->
<!--                pathLineSelectedStyle: {-->
<!--                  lineWidth: 6,-->
<!--                },-->
<!--                pathNavigatorStyle: {-->
<!--                  fillStyle: '#303133',-->
<!--                },-->
<!--              };-->
<!--            },-->
<!--          },-->
<!--        });-->

<!--        window.pathSimplifierIns = pathSimplifierIns;-->
<!--        pathSimplifierIns.setData([{ name: '运动轨迹', path: d }]);-->

<!--        // 创建一个巡航器-->
<!--        const navg0 = pathSimplifierIns.createPathNavigator(0, {-->
<!--          loop: true, // 循环播放-->
<!--          speed: 6000,-->
<!--        });-->
<!--        navg0.start();-->
<!--      });-->
<!--    },-->

<!--  },-->
<!--};-->
<!--</script>-->

<!--<style scoped>-->
<!--#container {-->
<!--  padding: 0;-->
<!--  margin: 0;-->
<!--  width: 100%;-->
<!--  height: 800px;-->
<!--}-->
<!--#panel {-->
<!--  position: fixed;-->
<!--  background-color: white;-->
<!--  max-height: 90%;-->
<!--  overflow-y: auto;-->
<!--  top: 10px;-->
<!--  right: 10px;-->
<!--  width: 280px;-->
<!--  z-index:100;-->
<!--}-->
<!--#panel .amap-call {-->
<!--  background-color: #009cf9;-->
<!--  border-top-left-radius: 4px;-->
<!--  border-top-right-radius: 4px;-->
<!--}-->
<!--#panel .amap-lib-driving {-->
<!--  border-bottom-left-radius: 4px;-->
<!--  border-bottom-right-radius: 4px;-->
<!--  overflow: hidden;-->
<!--}-->
<!--</style>-->
