要通过 Git 仓库文件通过 SSH 上传到服务器并建立官网，同时实现 Git 和服务器内容的同步更新，您可以遵循以下步骤。

### **概览**
1. 将本地的 Git 仓库内容推送到远程服务器。
2. 在远程服务器上创建并配置 Git 仓库。
3. 配置服务器上的自动拉取（通过 Git 远程拉取）以实现内容同步更新。

---

### **步骤 1: 在远程服务器上安装 Git**

首先，确保服务器上已安装 Git。

```bash
# 对于 Ubuntu/Debian 系统
sudo apt update
sudo apt install git -y

# 对于 CentOS/RHEL 系统
sudo yum install git -y
```

---

### **步骤 2: 在远程服务器上设置 Git 仓库**

1. **创建一个网站目录**（例如 `/var/www/html`）来存放您的官网文件。

```bash
# 创建网站根目录
sudo mkdir -p /var/www/html
cd /var/www/html
```

2. **初始化一个 Git 仓库**，并且将它连接到远程 Git 仓库。

```bash
# 初始化 Git 仓库
git init

# 设置远程仓库（例如 GitHub 仓库）
git remote add origin <您的远程 Git 仓库地址>
```

---

### **步骤 3: 上传官网文件到 Git 仓库**

在本地系统上，您需要将文件推送到远程 Git 仓库：

1. 在本地项目中初始化 Git 仓库（如果尚未初始化）：

```bash
cd /path/to/your/project
git init
git add .
git commit -m "Initial commit"
```

2. 将本地仓库与远程仓库关联：

```bash
git remote add origin <远程仓库地址>
```

3. 将本地的文件推送到远程仓库：

```bash
git push -u origin master
```

---

### **步骤 4: 在远程服务器上拉取 Git 仓库内容**

1. 在远程服务器上拉取最新的内容：

```bash
cd /var/www/html
git pull origin master
```

现在，您的服务器上 `/var/www/html` 目录将包含远程 Git 仓库中的官网文件。

---

### **步骤 5: 配置 Nginx（或其他 Web 服务器）**

假设您使用 Nginx 来托管您的网站。

1. **安装 Nginx**（如果尚未安装）：

```bash
# 对于 Ubuntu/Debian 系统
sudo apt install nginx -y

# 对于 CentOS/RHEL 系统
sudo yum install nginx -y
```

2. **配置 Nginx** 使其指向您的 Git 仓库同步目录：

编辑 Nginx 配置文件（如 `/etc/nginx/sites-available/default` 或 `/etc/nginx/conf.d/default.conf`）。

```bash
sudo nano /etc/nginx/sites-available/default
```

将内容更新为如下所示：

```nginx
server {
    listen 80;
    server_name example.com;  # 替换为您的域名

    root /var/www/html;  # 指定为 Git 拉取内容的目录

    index index.html index.htm index.php;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

3. **测试并重启 Nginx**：

```bash
sudo nginx -t  # 测试配置是否有误
sudo systemctl restart nginx  # 重启 Nginx
```

---

### **步骤 6: 配置自动同步（使用 Git Hook 或定时任务）**

要确保 Git 仓库的更新自动同步到服务器，您可以使用两种方式：

#### **(1) 使用 Git Hook 自动更新**
Git 提供了一个钩子（`post-receive`），可以在服务器上配置，当 Git 仓库接收到更新时自动触发拉取操作。

1. 在远程服务器的仓库目录中创建 `post-receive` 钩子文件：

```bash
cd /var/www/html/.git/hooks
nano post-receive
```

2. 在文件中加入以下内容：

```bash
#!/bin/bash
cd /var/www/html
git pull origin master
```

3. 保存并退出，确保钩子文件可执行：

```bash
chmod +x post-receive
```

现在每次向 Git 仓库推送内容时，服务器会自动拉取最新的文件。

#### **(2) 使用 Cron Job 定时拉取**

如果您不想依赖 Git Hook，可以设置一个定时任务（cron job）定期拉取 Git 仓库的更新。

1. 打开 crontab 编辑器：

```bash
crontab -e
```

2. 添加一个定时任务，例如每分钟同步一次：

```bash
* * * * * cd /var/www/html && git pull origin master
```

3. 保存并退出。

---

### **步骤 7: 测试同步功能**

1. 在本地仓库中更新网站内容并提交：

```bash
git add .
git commit -m "Update website content"
git push origin master
```

2. 在远程服务器上确认是否自动拉取了最新的内容。

如果您使用的是 Git Hook 或 cron job，服务器会自动同步并更新网站内容。

---

### **总结**

通过上述步骤，您可以：
- 在远程服务器上通过 Git 实现官网内容的同步更新。
- 配置 Git 仓库和 Web 服务器（如 Nginx）来提供官网。
- 设置自动化同步，确保每次 Git 仓库有更新时，网站内容也能随之更新。

这样，您的网站内容和 Git 仓库将始终保持一致，同时避免手动上传和更新文件的繁琐操作。