## Q1 ：HTML5 是什么，为什么重要？

**HTML5 是 HTML 的最新版本标准**，它不仅增强了网页结构的表现能力，还引入了丰富的语义化标签和原生功能（如音视频支持、本地存储等），使开发者能够更高效地构建现代 Web 应用。

在 HTML5 中，我们通常会在文档开头使用：

```html
html

 代码解读
复制代码<!DOCTYPE html>
```

这行代码的作用是告诉浏览器这是一个 HTML5 文档，确保浏览器以标准模式渲染页面。

------

## Q2 : HTML 标签有哪些分类？

------

### 1.按布局需求，可分为行内元素标签和块级元素标签：

#### 1.1 行内元素（Inline Elements）

- **特点**：默认情况下，行内元素不会独占一行，宽度由内容决定，不能设置宽高。

- 常见标签

  ：

  - `<a>`：超链接
  - `<span>`：文本容器，常用于样式控制

> ✅ 小技巧：调试的时候可以给元素添加背景色，以便观察布局效果。

示例：

```html
html

 代码解读
复制代码<span style="background-color: yellow;">这是一个 span</span>
<a href="#">这是一个链接</a>
```

#### 1.2 块级元素（Block-level Elements）

- **特点**：每个块级元素独占一行，默认宽度为父容器的 100%，可以设置宽高。

- 常见标签

  ：

  - `<div>`：通用容器
  - `<ul>` / `<li>`：无序列表
  - `<p>`：段落
  - `<header>` / `<footer>` / `<nav>`：语义化标签

示例：

```html
html

 代码解读
复制代码<div style="background-color: lightblue;">这是一个 div</div>
<p>这是一个段落</p>
```

------

### 2. 按功能分，可分为语义化标签、表格标签、表单标签等...

除了布局相关的分类外，HTML 标签还可以根据其功能进行划分，尤其是一些新增的语义化标签，在大厂面试中经常被问到。

#### 2.1 语义化标签（Semantic Tags）

HTML5 引入了许多具有明确含义的语义化标签，这些标签比传统的 `<div>` 更具可读性和可维护性，也有利于 SEO 和爬虫抓取。

| 标签        | 含义             |
| ----------- | ---------------- |
| `<header>`  | 页面或区块的头部 |
| `<main>`    | 页面主要内容     |
| `<footer>`  | 页面或区块的底部 |
| `<nav>`     | 导航区域         |
| `<section>` | 内容区块         |
| `<article>` | 独立文章内容     |
| `<aside>`   | 侧边栏或辅助信息 |

示例：

```html
html

 代码解读
复制代码<header>
  <h1>网站标题</h1>
  <nav>
    <ul>
      <li><a href="#home">首页</a></li>
      <li><a href="#about">关于我们</a></li>
    </ul>
  </nav>
</header>
<main>
  <article>
    <h2>文章标题</h2>
    <p>这是文章内容。</p>
  </article>
</main>
<footer>
  <p>© 2025 版权所有</p>
</footer>
```

#### 2.2 表格相关标签

表格用于展示结构化的数据，虽然现在不常用作布局工具，但在数据展示方面依然不可或缺。

- `<table>`：定义表格
- `<tr>`：表格行
- `<td>`：单元格
- `<th>`：表头单元格（加粗居中显示）

示例：

```html
html

 代码解读
复制代码<table border="1">
  <tr>
    <th>姓名</th>
    <th>年龄</th>
  </tr>
  <tr>
    <td>张三</td>
    <td>28</td>
  </tr>
</table>
```

#### 2.3 表单相关标签

表单是用户与网页交互的重要方式，常用于登录、注册等功能。

- `<form>`：表单容器
- `<input>`：输入框（文本、密码、复选框等）
- `<select>` / `<option>`：下拉选择框
- `<textarea>`：多行文本输入

示例：

```html
html

 代码解读
复制代码<form action="/submit" method="post">
  <label for="username">用户名：</label>
  <input type="text" id="username" name="username"><br><br>

  <label for="color">喜欢的颜色：</label>
  <select id="color" name="color">
    <option value="red">红色</option>
    <option value="blue">蓝色</option>
  </select><br><br>

  <input type="submit" value="提交">
</form>
```