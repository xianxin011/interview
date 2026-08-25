# JavaScript

1. bind、call、apply区别
- call 和 apply 都是为了改变 this 的指向。作用是相同的，唯一的区别是传参的类型不同

- 除了第一个参数外，call 可以接收一个参数列表，apply 只接受一个数组

```js
let a = {
value: 1
}
function getValue(name, age) {
console.log(name)
console.log(age)
console.log(this.value)
}
getValue.call(a, 'yck', '24')
getValue.apply(a, [ 'yck', '24'])
```

- bind 和其他两个方法作用相同，只是会返回一个函数
2. 原型链是什么
- 每个函数都有 ***prototype*** 属性，除了**Function.prototype.bind()**,该属性指向原型

- 每个对象都有`__proto__`属性，指向创建该对象的构造函数的原型。其实这个属性指向了 **[[prototype]]** ,但是 **[[prototype]]** 是内部属性，我们并不能访问到，所以用`__proto__`来访问。

- 对象可以通过`__proto__`来寻找不属性该对象的属性，`__proto__`将对象连接起来组成链
3. 怎么判断对象类型
- 可以通过` Object.prototype.toString.call(xx)` 

- `instanceof `可以正确的判断对象的类型， 因为内部机制是通过判断对象的原型链中是不是能找到类型的 `prototype`
4. 基本数据类型和引用类型在存储上的差别
- 前者存储在栈上， 后者存储在堆上
5. `setTimeout` 倒计时误差
- JS 是单线程的，所以 setTimeout 的误差其实是无法被完全解决的，原因
  
  有很多， 可能是回调中的，有可能是浏览器中的各种事件导致 。这也是为什么
  
  页面开久了，定时器会不准的原因， 当然我们可以通过⼀定的办法去减少这个
  
  误差
  
  ```js
  var period = 60 * 1000 * 60 * 2
  var startTime = new Date().getTime();
  var count = 0
  var end = new Date().getTime() + period
  var interval = 1000
  var currentInterval = interval 
  function loop() {
  count++
  var offset = new Date().getTime() - (startTime + count * interval); // 代码
  var diff = end - new Date().getTime()
  var h = Math.floor(diff / (60 * 1000 * 60))
  var hdiff = diff % (60 * 1000 * 60)
  var m = Math.floor(hdiff / (60 * 1000))
  var mdiff = hdiff % (60 * 1000)
  var s = mdiff / (1000)
  var sCeil = Math.ceil(s)
  var sFloor = Math.floor(s)
  currentInterval = interval - offset // 得到下⼀次循环所消耗的时间
  console.log( '时： '+h, '分： '+m, '毫秒： '+s, '秒向上取整： '+sCeil, '代码执行时间：
  setTimeout(loop, currentInterval)
  }
  setTimeout(loop, currentInterval)
  ```
6. 数组降维

```js
[1,[2],[3]].flatMap(v=>v)
```

如果想将一个多维数组彻底降维，可以

```js
const flattenDeep = ( arr) = > Array. isArray( arr)
? arr.reduce( (a, b) => [...a, ...flattenDeep(b)] , [])
: [arr]
```

7. 如何解决跨域

因为浏览器出于安全考虑，有同源策略。协议、域名、端口有一个不同就是跨域，请求会失败

- JSONP

JSONP 的原理很简单，就是利用` <script> `标签没有跨域限制的漏洞

```js
< script src= " http: / / domain/ api? param1 = a& param2 = b& callback= jsonp" > < / script>
<script>
function jsonp(data) {
console.log(data)
}
</script>
```

在开发中可能会遇到多个 JSONP 请求的回调函数名是相同的， 这时候就需要自己封装⼀个 JSONP ， 以下是简单实现

```js
function jsonp( url, jsonpCallback, success) {
let script = document.createElement("script");
script.src = url;
script.async = true;
script.type = "text/javascript";
window[jsonpCallback] = function(data) {
success && success(data);
};
document.body.appendChild(script);
}
jsonp(
"http://xxx",
"callback",
function(value) {
console.log(value);
}
);
```

- CORS

CORS 需要浏览器和后端同时支持

浏览器会自动进⾏ CORS 通信， 实现 CORS 通信的关键是后端 。只要后端实现了

CORS ，就实现了跨域

服务端设置 Access-Control-Allow-Origin 就可以开启 CORS 。 该属性表示哪些域名

可以访问资源， 如果设置通配符则表示所有网站都可以访问资源

- document.domain
  
  该方式只能用于二级域名相同的情况下， 比如 a.test.com 和 b.test.com 适用于该方式
  
  只需要给页面添加 document.domain = 'test.com' 表示二级域名都相同就可以实现跨
  
  域
