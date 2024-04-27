<template>
  <div id="app">
    <el-container>
      <el-header style="height: 35px">
        <h1 class="title">外卖系统管理员守则</h1>
      </el-header>
      <el-main>
        <el-row :gutter="20" justify="center">
          <el-col :span="24">
            <el-row :gutter="20" justify="center">
              <el-col :span="24">
                <el-card :class="{'animated-card': animated}" class="rule-card" @mouseover="toggleAnimation">
                  <h2 class="rule-title">{{ adminRules[0].title }}</h2>
                  <p class="rule-content">{{ adminRules[0].content }}</p>
                </el-card>
              </el-col>
            </el-row>

            <el-row :gutter="20" justify="center">
              <el-col :span="12" v-for="(rule, index) in adminRules" :key="index">
                <el-card :class="{'animated-card': animated}" class="rule-card" @mouseover="toggleAnimation">
                  <h2 class="rule-title">{{ rule.title }}</h2>
                  <p class="rule-content">{{ rule.content }}</p>
                </el-card>
              </el-col>
            </el-row>
          </el-col>
        </el-row>
      </el-main>
    </el-container>
  </div>
</template>
<script>
export default {
  name:'Home',
  data() {
    return {
      adminRules: [
        {
          title: '信息保密与安全性',
          content: '确保用户个人和业务信息不被泄露。确保系统具备高水平的安全性，包括数据传输加密、身份验证等措施。定期进行安全性审计，及时修复潜在的漏洞和风险。',
        },
        {
          title: '系统稳定性',
          content: '定期进行系统维护，确保系统持续稳定运行。及时处理系统故障和问题，最大程度减少对用户和商家的影响。',
        },
        {
          title: '合规性与法律遵守',
          content: '遵循相关法律法规，确保系统运营符合法规要求。关注并及时更新相关法律法规的变化，调整系统运营策略以确保合规性。',
        },
        {
          title: '性能优化',
          content: '持续监控系统性能，采取措施优化系统响应速度和效率。根据用户和商家的反馈，优化系统界面和用户体验。',
        },
        {
          title: '备份与恢复',
          content: '定期进行系统数据备份，确保数据的安全性和可恢复性。制定有效的灾难恢复计划，以最小化系统故障对业务的影响。',
        },
        {
          title: '更新与升级',
          content: '定期进行系统软件和硬件的更新与升级，确保系统处于最新的稳定版本。在进行重大更新前，提前通知相关用户和商家，并确保更新过程中的顺畅过渡。',
        },
        {
          title: '团队协作',
          content: '与相关部门和团队密切合作，确保系统与其他业务环节的协调一致。保持良好的沟通和团队合作，共同解决问题和推动系统的不断优化。',
        },
        {
          title: '用户反馈与改进',
          content: '关注用户和商家的反馈，认真倾听意见，及时做出改进和调整。鼓励用户积极参与，提供建议和意见，促进系统的不断完善。',
        },
      ],
      animated: false,
    };
  },
  methods:{
    toggleAnimation() {
      this.animated = !this.animated;
    },
  }
};
</script>

<style>
.title {
  color: #3498db;
  font-size: 32px;
  margin-bottom: 20px;
}

.animated-card {
  transition: transform 0.3s ease-in-out;
}

.rule-card {
  border-radius: 8px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  transform: scale(1);
}

.rule-card:hover {
  transform: scale(1.05);
}

.rule-title {
  color: #3498db;
  font-size: 20px;
  margin-bottom: 10px;
}

.rule-content {
  color: #555;
  font-size: 16px;
  line-height: 1.6;
}
</style>
