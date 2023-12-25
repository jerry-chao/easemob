# 多中心设计

多中心，分批的步骤，结构迭代的思路，框架的描述，思考

## RoadMap

- [X] 实现消息回调的接口
- [ ] 实现消息的转发的逻辑
- [ ] 实现好友添加的逻辑
- [ ] 实现群组创建，添加跨集群的成员
- [ ] 实现群组消息的跨集群发送

## 需求
- 实现用户、元数据等基础数据的隔离，不同的应用可能部署在不同的区域
- 不同区域的应用能够通信
- 各个区域主要和本区域的用户进行通信

## 功能
- 实现全球互联互通
- 数据中心的区域本地化

## 实现细节
- 实现语言的选型
	- elixir

### 核心业务场景

前提说明： 由于环信当前的体系不能支持跨应用的数据进行互通，所以不同区域的应用采用不同的环信appkey，账号级别增加对应的区域识别，这里假设有app1， app2，所以账号的命名为

- 1_tom, 1_marry表示应用1的tom，marry
- 2_alice, 2_chris表示应用2的alice，chris
- hx1：app1所在的环信数据中心
- hx2： app2所在的环信数据中心
- appServer1：app1所在的应用服务
- appServer2: app2所在的应用服务
- *MetaData: 特定账号的元数据信息
- GroupMetaData：群组的元数据信息

### 发送消息
	- 核心过程如下所示
		- app1_1_tom发送消息给app1_2_alice的账号
		  logseq.order-list-type:: number
		- 通过配置的发送前回调，appServer1接收到该消息，判断该消息为跨应用的消息
		  logseq.order-list-type:: number
		- appServer1将消息直接转发给hx2的服务，信息修改为app2_1_tom发送给app2_2_alice的消息
		  logseq.order-list-type:: number

### 添加好友
- 核心过程如下所示
	- app1_1_tom添加app1_2_alice的账号为好友
	  logseq.order-list-type:: number
	- 通过配置的发送后回调，appServer1接收到事件，判定为跨集群的添加添加好友
	  logseq.order-list-type:: number
	- appServer1将事件直接转发给hx2的服务，信息修改为app2_1_tom添加app2_2_alice为好友
	  logseq.order-list-type:: number
**注意事项**
好友属性等不属于两者共有的属性，所以该类动作不进行相应的同步

### 创建群组
创建群组的过程和普通的创建群组没有区别，区别从添加一个非本app的成员开始，这里省略标准的群组创建过程。
#### 添加非本app的群组成员
- 核心过程如下所示
	- app1_1_tom添加app1_2_alice到群组中
	  logseq.order-list-type:: number
	- 检查群组属性是否为跨应用，设置为跨应用的群组
	  logseq.order-list-type:: number
	- 同步该群组的成员列表到hx2的服务
	  logseq.order-list-type:: number
		- 创建群组，所有的信息均为默认，因为群组的metadata归属于app1
		  logseq.order-list-type:: number
		- 添加成员到群组
		  logseq.order-list-type:: number
**注意事项**
- 群组属性等不属于两者共有的属性，所以不会同步，但是相应的变更通知会同步到hx2上