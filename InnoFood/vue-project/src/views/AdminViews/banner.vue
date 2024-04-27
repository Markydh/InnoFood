<template>
  <div class="banner-container">
    <el-table :data="ads" style="width: 100%" border>
      <el-table-column label="广告名称" prop="name" align="center"></el-table-column>
      <el-table-column label="图片" align="center">
        <template slot-scope="scope">
          <img :src="scope.row.psrc" alt="Advertisement Image" class="ad-image">
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center">
        <template slot-scope="scope">
          <el-button @click="openEditDialog(scope.row)" class="edit-button">编辑</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- Edit Dialog -->
    <el-dialog :visible.sync="showEditDialog" title="编辑广告" @closed="closeEditDialog">
      <el-form label-width="80px">
        <el-form-item label="广告名称">
          <el-input v-model="editedAd.name"></el-input>
        </el-form-item>
        <el-form-item label="图片" >
          <el-upload
              class="avatar-uploader"
              action="http://localhost:9091/file/upload"
              :show-file-list="false"
              :on-success="handleUploadSuccess"
              :before-upload="beforeUpload"
          >
            <el-button slot="trigger" size="small">上传图片</el-button>
          </el-upload>
          <img :src="editedAd.image" alt="Edited Image" class="edited-image">
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="showEditDialog = false">取消</el-button>
        <el-button type="primary" @click="saveEdits">保存</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "Banner",
  data() {
    return {
      ads: [],
      showEditDialog: false,
      editedAd: {
        id: null,
        image: "",
        name: "",
        file: null, // 添加 file 属性
      },
    };
  },
  created() {
    this.load();
  },
  methods: {
    load() {
      this.request.get('/file/banner').then(res => {
        this.ads = res;
      });
    },
    openEditDialog(ad) {
      this.editedAd = { ...ad };
      this.editedAd.image = ad.psrc;
      this.showEditDialog = true;
    },
    handleUploadSuccess(response) {
      console.log('response', response);
      this.editedAd.image = response;
    },
    beforeUpload(file) {
      this.editedAd.file = file;
      return true;
    },
    saveEdits() {
      const formData = new FormData();
      formData.append('file', this.editedAd.file);

      const infoBlob = new Blob([JSON.stringify({
        id: this.editedAd.id,
        name: this.editedAd.name,
        image: this.editedAd.image
      })], { type: 'application/json' });

      formData.append('info', infoBlob);

      this.request.post('/file/save', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      }).then(() => {
        this.$message.success('保存成功！');
        this.showEditDialog = false;
        this.load();
      }).catch(error => {
        console.error('保存失败：', error);
        this.$message.error('保存失败！');
      });
    },
    closeEditDialog() {
      this.editedAd = { id: null, name: "", image: "", file: null }; // 重置 file 属性
    },
  },
};

</script>

<style scoped>
.banner-container {
  background-color: #f8f8f8;
  padding: 20px;
}

.el-table {
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  font-size: 14px;
  border: 1px solid #e0e0e0;
  border-radius: 5px;
}

.el-table th,
.el-table td {
  text-align: center;
  padding: 10px;
}

.el-dialog {
  background-color: #fff;
  border-radius: 5px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.ad-image,
.edited-image {
  width: 80px;
  height: 60px;
  border-radius: 5px;
  margin-top: 10px;
  display: block;
  margin: 0 auto;
  transition: transform 0.3s;
}

.ad-image:hover,
.edited-image:hover {
  transform: scale(1.1);
}

.edit-button:hover {
  background-color: #45a049;
}

.edit-button {
  padding: 5px 10px;
  background-color: #4caf50;
  color: #fff;
  border: none;
  border-radius: 3px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.edit-button:hover {
  background-color: #45a049;
}
</style>
