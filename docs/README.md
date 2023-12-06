# winda documents

> https://docsify.js.org/#/zh-cn/quickstart

<!-- TOC -->

- [winda documents](#winda-documents)
    - [组织结构](#组织结构)
    - [配置说明](#配置说明)

<!-- /TOC -->

## 组织结构

> 每一部分内容会有专门的`readme`解释

插件主目录均以小写命名，本文档只提供中文说明；

- 基本组织结构：

|Path|Name|Note|
|:-:|:-:|:-:|
|libs|库|第三方依赖库|
|locales|本地化|插件本地化|
|theme|主题扩展资源|插件本地资源|
|extend|第三方扩展|其他插件扩展接口|


- 核心内容列表`core`:

> winda/core

|Path|Name|Note|
|:-:|:-:|:-:|
|blizz|暴雪||
|constant|常量||
|database|数据||
|debug|调拭||
|default|设置||
|init|初始化||
||||


- 可视化功能列表`entities`:

> 该部分为插件可视化内容，子目录均以首字母大写命名，各个部分提供的功能是相互独立的，可按需求进行拆分；

|Path|Name|Note|
|:-:|:-:|:-:|
|_Base|基类||
|Bags|背包||
|Bars|动作栏||
|Buffs|增/减益||
|Chat|聊天||
|Maps|地图||
|Nameplate|姓名版||
|Raid|团队||
|Tooltip|提示||
|UnitFrame|头像||

- 可视化设置列表`settings`:

> （前提：此部分可以达到拆分的目的，注意与entities的耦合度）
> 该部分为可视化内容的设置子页面，与可视化内容相对应，**独立于可视化功能列表**，为其补充用户设置项；

|Path|Name|Note|
|:-:|:-:|:-:|
|_Base|基类||
||||


## 配置说明

> theme/base

本插件支持主题更换，可以参照以上路径中的材质，收集安装自己的主题，具体实施方法如下：


