-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2023-11-12 13:25:23
-- 服务器版本： 5.7.40-log
-- PHP 版本： 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `learning`
--

-- --------------------------------------------------------

--
-- 表的结构 `article`
--

CREATE TABLE `article` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `content` text NOT NULL COMMENT '文章内容',
  `image` text COMMENT '上传图片路径',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '文章作者',
  `category_id` bigint(20) UNSIGNED NOT NULL COMMENT '文章分类',
  `praise_num` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '点赞数量',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态:0=草稿,1=发布',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `article`
--

INSERT INTO `article` (`id`, `title`, `content`, `image`, `user_id`, `category_id`, `praise_num`, `status`, `gmt_create`, `gmt_modified`) VALUES
(2, '0 基础 Java 自学之路', '前言<br/><br/>如果你想自学 Java，认真看完本文，你以后的职场生涯至少少走1年弯路。<br/><br/>本文会持续更新，建议收藏。<br/><br/>初衷<br/>在 CSDN 上经常有同学私聊我询问 “如何自学 Java”、“想转行 Java 靠谱吗” 等问题，因为自己也是在大学时自学的 Java，所以我能理解这些同学的痛苦和迷茫。<br/><br/>写这篇文章前，我看了一些网上 Java 自学的文章，很多我都不太满意，有的甚至让我感到愤怒，要么是站在现有的视角侃侃而谈，要么是纯粹的瞎编骗小白。<br/><br/>很多文章都有一个老毛病：完全没有从小白的视角去思考，内容太多，什么微服务、架构、大数据都来了，这根本不是自学阶段该去看的东西，小白看了这些文章，只会越看越懵逼，根本没法下手。<br/><br/>其实我在18年写过一篇“0基础Java自学之路”，但是现在来看，当时那篇文章写的过于简单，只是提供了一个思路，但是很多内容没有写。<br/><br/>如今已经过去了3年，我对于这个话题又有了一些新的思考，同时为了拯救广大正处于水深火热的同学们，于是，我决定重新写一篇自学教程。<br/><br/>自我介绍<br/>在写本文前有必要介绍下我自己，让大家更好的去比较和参考。<br/><br/>我大学是普通本科，大三开始自学的 Java，自学了一年，但是我是计算机专业的，所以有C语言基础，但是我这一年的自学走了不少弯路，花了很多时间学了很多后面根本没用到的东西：Oracle、Hibernate、Struct2、JBPM 等等，还有就是缺少有经验的人的指导，所以容易抓不到重点，所以也浪费了不少时间。<br/><br/>不过当时还没有现在这么内卷，所以我在大四秋招刚开始就找到工作了。<br/><br/>行业现状<br/>程序员现状<br/>由于程序员的薪水比较高，最近几年有很多其他专业的人涌进了程序员行业，加速了这个行业的内卷，但是据某招聘网上的数据统计，程序员当前的需求量还是远高于全行业的平均线的。所以，程序员的现状我觉得是不错的，至少几年内是无需担心的。<br/><br/>Java 现状<br/>最近几年，Go、Python 等语言快速崛起，大有挑战 Java 地位的趋势，但是 Java 毋庸置疑仍是当前互联网行业里招聘需求量最大的。<br/><br/>众多大厂：阿里、美团、快手、拼多多、滴滴、网易等，都是以 Java 为公司的主语言，部分大厂：腾讯、百度、字节等，虽然以其他语言为主语言，但是多多少少也会有一些 Java 岗。<br/><br/>所以，Java 的现状及未来，我觉得都是比较不错的。岗位多也代表着机会多，对于新人来说比较友好，所以我个人是比较推荐新人学 Java 的。<br/><br/>自学前你应该知道<br/>自学前请做好心理准备，自学是一个既寂寞又漫长的过程，如果想踏进来，请做好放弃几乎所有娱乐生活的准备，包括过年的时候。如果只是抱着三天打鱼两天晒网的态度，那我建议还是放弃吧。<br/><br/>但是如果你能坚持下来，我相信一定能有所回报，我自己就是个例子，我走了那么多弯路，跟着本文走，你们没理由比我当时更差。<br/><br/>自学预估周期<br/>自学的周期我给大家定了一个参考时间：6个月，平均每天6-8小时，共1200个小时左右，大致安排：<br/><br/>1、3个月基础知识学习和强化。<br/><br/>2、2个月 SSM 项目实战反复练习，项目实战同时也在复习和巩固之前的基础知识。<br/><br/>3、1个月面试高频题准备，看面试题其实也会增加自己的专业知识，而且可能比你想象的要多，不夸张的说，前几年我从面试题里学到的知识可能比工作里获得的还多。<br/><br/>自学教程获取<br/>授人以鱼不如授人以渔，一个简单又靠谱的的教程获取方式：B站搜索关键字+教程，例如：Java基础教程、MySQL教程、JavaWeb教程、SSM整合教程、Java项目实战等等，然后按“最多点击”排序，在前几个里寻找一个合适的即可，一般点击高的都是质量还可以的。<br/><br/>很重要的建议<br/>1、爱因斯坦的成功公式：成功 = 效率 * 时间，自学也一样，需要劳逸结合，不要搞的太累，否则效率下降，花再多时间也没用。<br/><br/>2、自学是一个漫长的过程，循序渐进、保持耐心，如果可以，找个伴一起学习，互相鼓励，互相交流，可以让自己更有动力坚持下去。<br/><br/>3、将自己的学习过程记录下来，当你发现累计的越来越多的时候，心里会有一种小成就感，这会提高你学习的动力。<br/><br/>4、专注于重点知识的学习，本文介绍的基本涵盖了当前你应该学习的内容，没有提到的大部分是没那么重要的，如果你无法判断是否重要，可以在本文下面留言，我会一一解答，至于像一些什么：k8s、hadoop、hbase 等等，看都别看，对于当前的你来说只是浪费时间。<br/><br/>5、利用好搜索引擎，有什么问题就百度，新手大部分的问题百度都能解决。<br/><br/>6、看视频不要看书，当前阶段的你看任何书，包括大名鼎鼎的《Java编程思想》都是浪费时间。<br/><br/>7、看视频要跟着敲一遍甚至多遍，如果只看视频不跟着敲，你会发现最后啥都学不会。<br/><br/>8、视频中一些介绍历史的视频可以过一遍简单了解就行，节省点时间。<br/><br/>9、关于视频教程的选取：选择近2~3年的教程，讲师让自己听着舒服即可，点击高的视频水平基本差不多。<br/><br/>10、不懂的知识可以反复看，例如同一个知识点有两套教程，看完第一个没完全理解，可以再看第二个，加深印象，也可以查些资料帮助理解。<br/><br/>自学知识点<br/>1、Java SE<br/>1.1、Java基础<br/><br/>基础概念/语法：面向对象（继承、封装、多态）基础、包、类、接口、方法、对象、属性、第一个 Java 程序。<br/><br/>数据类型：1）基本数据类型8种：byte、short、int、long、float、double、char、boolean；2）引用数据类型<br/><br/>变量类型：局部变量、实例变量（成员变量）、类变量（静态变量）<br/><br/>修饰符：public、private、不写、protected、static、final、abstract、synchronized ，volatile <br/><br/>运算符：1）算术运算符：+、-、*、/、%、++、--；2）关系运算符：==、!=、>、<、>=、<=；3）逻辑运算符：&&、||、!；4）赋值运算符：=、+=、-=、*=、/=；5）条件运算符：Object x = (expression) ? value if true : value if false；<br/><br/>循环结构：for 循环、while 循环、do...while 循环<br/><br/>条件语句：if...else、if...else if...else<br/><br/>异常处理：try...catch...finally、throws、throw<br/><br/>字符串：String、StringBuilder、StringBuffer<br/><br/>其他：switch case、数组、日期时间、枚举、使用 IDE 进行 DEBUG<br/><br/>1.2、集合<br/><br/>Map：HashMap（最重要）、ConcurrentHashMap、TreeMap、Hashtable<br/><br/>List：ArrayList（最重要）、LinkedList<br/><br/>Set：HashSet（最重要）、TreeSet<br/><br/>1.3、多线程<br/><br/>线程生命周期<br/><br/>创建线程的三种方式：继承 Thread、实现 Runnable；实现 Callable <br/><br/>ThreadPoolExecutor（线程池）<br/><br/>锁：synchronized 和 Lock<br/><br/>1.4、I/O流<br/><br/>1.5、网络编程<br/><br/>1.6、反射<br/><br/>1.7、泛型<br/><br/>1.8、注解<br/><br/>小结：<br/><br/>1、该阶段很重要，建议至少看两套不同的教程。由于每个老师的观点都会有一些片面性，当遇到疑惑的时候，可以看看其他老师的理解，可能就想通了。<br/><br/>2、看第一遍时会比较慢，第二遍会快一点，已经掌握的知识可以快速带过。<br/><br/>3、有疑问的知识多看几遍，也可以网上看点博文辅助理解，实在看不懂的可以先记下来，后面学到一定程度可能就理解了。<br/><br/>4、对于重点知识，可以做笔记来加深自己的理解，也方便后续自己复习。<br/><br/>5、Java基础、集合、多线程是核心中的核心。<br/><br/>章节目标：熟练掌握该章节所列的所有 Java 核心基础知识，能熟练的编写 Java 程序。<br/><br/>配套教程<br/><br/>【尚硅谷】Java零基础教程视频<br/><br/>【动力节点_2017年版】Java零基础教程视频<br/><br/>【动力节点_2020年版】Java零基础教程视频<br/><br/>2、SQL<br/>2.1、SQL<br/><br/>1）了解基础概念；2）掌握 DML 语句的使用：SELECT、UPDATE、INSERT 和 DELETE；3）掌握 DDL 语句的使用：操作表时用到的一些SQL语句。例如：CREATE、ALTER、DROP等。<br/><br/>2.2、JDBC<br/><br/>掌握基本的使用。<br/><br/>配套教程<br/><br/>【动力节点】JDBC从入门到精通视频教程-JDBC实战精讲<br/><br/>【尚硅谷】JDBC核心技术(新版jdbc)<br/><br/>2.3、MySQL<br/><br/>掌握基本的使用。<br/><br/>配套教程<br/><br/>【尚硅谷_2019版】李玉婷2019版MySQL基础（P243---P326）<br/><br/>【尚硅谷_2017版】MySQL数据库全套完整版（sql数据库优化）<br/><br/>【狂神说Java】MySQL最新教程通俗易懂<br/><br/>【动力节点】MySQL基础入门-mysql教程-数据库实战<br/><br/>章节目标：熟练掌握SQL语句的基础使用，了解JDBC和MySQL的基础使用。<br/><br/>3、Java Web<br/>3.1、偏前端内容<br/><br/>HTML、CSS、JS（JavaScript）、Ajax、jQuery<br/><br/>3.2、偏后端内容<br/><br/>Servlet、JSP、Request、Response、HTTP、Session、Cookie、Filter、Listener<br/><br/>Java Web初级内容的相关技术在当前 Java 后端已经比较少直接使用到了，最近几年的 Java 程序员甚至可能都没接触过。大部分是被下一节的 SSM 框架给封装代替掉了，但是这一章节初学者还是有必要认真学习一下，做到能看得懂、能照着改。<br/><br/>章节目标：了解该章节所涉及的知识，做到能看得懂、能照着改。对于 Servlet 可以稍微多留意一下，Servlet 是本章节比较重要的知识。<br/><br/>配套教程<br/><br/>【尚硅谷】最新版JavaWeb全套教程,java web零基础入门完整版<br/><br/>【黑马程序员】完整JavaWeb快速入门教程<br/><br/>【狂神说Java】JavaWeb入门到实战<br/><br/>4、常用工具<br/>4.1、Tomcat<br/><br/>Web 应用服务器。<br/><br/>4.2、Maven<br/><br/>项目构建管理，简单理解为用于导入 Jar 依赖的工具。<br/><br/>配套教程<br/><br/>【尚硅谷】Maven视频(maven零基础入门)<br/><br/>4.3、Git<br/><br/>分布式版本控制系统，简单理解为代码管理工具。<br/><br/>配套教程<br/><br/>【尚硅谷】Git与GitHub基础全套完整版教程<br/><br/>【狂神说Java】Git最新教程通俗易懂<br/><br/>章节目标：需要知道有这么些工具，然后掌握其基本的使用即可。<br/><br/>5、核心框架<br/>5.1、Spring<br/><br/>1）掌握基本的使用；2）掌握核心概念，需重点注意的知识点：IoC（控制翻转）、DI（依赖注入）、AOP（面向切面编程）、事务控制。<br/><br/>配套教程<br/><br/>【尚硅谷】Spring5框架最新版教程（idea版）<br/><br/>【狂神说Java】Spring5最新完整教程IDEA版通俗易懂<br/><br/>【黑马程序员】Spring教程IDEA版<br/><br/>【动力节点】2020最新Spring框架教程【IDEA版】<br/><br/>5.2、SpringMVC<br/><br/>1）掌握基本的使用；2）掌握核心概念，需重点注意的知识点：MVC 架构、Controller 里的各种注解、一个 HTTP 请求的流程。<br/><br/>配套教程<br/><br/>【尚硅谷】SpringMVC实战教程完整版(spring mvc框架源码解析)<br/><br/>【狂神说Java】SpringMVC最新教程IDEA版通俗易懂<br/><br/>【黑马程序员】SpringMVC教程IDEA版<br/><br/>【动力节点】2020最新SpringMVC教程【IDEA版】<br/><br/>5.3、MyBatis<br/><br/>1）掌握基本的使用；2）掌握核心概念，需重点注意的知识点：XML 文件力的 SQL 语法、接口（interface）和 SQL 的映射。<br/><br/>配套教程<br/><br/>【尚硅谷】MyBatis实战教程全套完整版<br/><br/>【狂神说Java】Mybatis最新完整教程IDEA版通俗易懂<br/><br/>【黑马程序员】Mybatis教程IDEA版<br/><br/>【动力节点】2020最新MyBatis教程【IDEA版】<br/><br/>5.4、Spring Boot<br/><br/>掌握基本的使用。<br/><br/>配套教程<br/><br/>【尚硅谷】2021版SpringBoot2零基础入门springboot全套完整版<br/><br/>【狂神说Java】SpringBoot最新教程IDEA版通俗易懂<br/><br/>章节目标：了解 SSM 框架的基本使用，该阶段可以不用做到完全理解，可以在项目实战里去通过实际的例子加深自己对 SSM 的理解。<br/><br/>6、项目实战<br/>准备 2~3个项目实战，将之前所学的知识点应用起来，做出一个真正的项目（网站）。学习的项目必须使用 SSM 框架，加深自己对 SSM 的理解。该阶段所做的项目，也是未来写在你简历里的“项目经验”，需要跟着敲一遍。<br/><br/>目标：将之前所学知识串联起来，熟练掌握一个 Web 项目的完整流程，通过项目加深对之前所学知识的理解，特别是 SSM 框架知识。<br/><br/>配套教程<br/><br/>【尚硅谷】SSM框架实战，ssm整合教程<br/><br/>【狂神说Java】SSM框架最新整合教学IDEA版<br/><br/>7、面试准备<br/>如果对于上述的 Java 基础知识你已经能熟练使用，然后也能熟练搭建一个简单的 SSM 的项目。那我建议你可以将时间多花在面试准备这一章节上，面试准备的重要程度可能超过很多人的想象。同时在看面试题的过程中也能加深自己对之前知识的认知。<br/><br/>7.1、重点知识点<br/><br/>Java 基础高频面试题<br/>​集合高频面试题，重点：HashMap<br/>多线程高频面试题，重点： synchronized、线程池<br/>MySQL高频面试题，重点：索引、锁<br/>Spring/SpringMVC/MyBatis高频面试题，重点：Spring<br/>SSM 实战项目<br/>该模块对应我们上面学习的知识，但是只会使用是很难满足当前的面试要求的，因此需要针对这些知识进行面试强化，具体的题目可以看下我的面试系列文章。<br/><br/>7.2、进阶知识点<br/><br/>JVM<br/>Redis<br/>Kafka<br/>Zookeeper<br/>Dubbo<br/>算法：常见的算法，二分、排序等，可以刷剑指offer的题目<br/>设计模式：可以主要看下单例模式<br/>你可能会有疑问，为什么进阶里列的知识点都是之前上面没有提过的，还需要准备面试题。之所以补充进阶部分，主要是为了应对当前互联网行业内卷越来越严重的现象，这几个知识点都是当前 Java 面试的高频考点，但是要像前面的基础知识一样，系统的学习这些知识对于初学者当前阶段来说基本不太可能，所以一个比较合适的方式是直接看高频面试题，然后将高频面试题带着理解记下来。<br/><br/>章节目标：各个知识点的高频面试题熟记于心，尽量做到理解，不能理解就先硬背。<br/><br/>面试真题可以参考我的文章：Java 基础高频面试题（2021年最新版）。<br/><br/>常见问题<br/>1、自学时遇到不懂的知识怎么办？<br/><br/>答：百度/谷歌找答案，初学者遇到的问题基本百度上都能找得到，多利用搜索引擎，锻炼自己的解决问题的能力，这个能力会贯穿你的整个程序员生涯。<br/><br/>2、普通人按本文自学后能达到什么程度？<br/><br/>答：如果你确实很努力的花了超过1000个小时，按本文的路线去学习，掌握了本文所介绍的知识，那我相信你找个工作是不难的。<br/><br/>3、在网上看到有人自学6个月进 BAT？<br/><br/>答：自学6个月进 BAT 有吗？我相信是有的。多吗？我相信是海底捞针。<br/><br/>针对这个话题，大部分是假的，更多的是一些人/机构用于打广告的，看了文章内容99%要你付费加群或买资料。<br/><br/>4、自学还是培训机构？<br/><br/>答：坦白的讲，培训机构肯定比自学要轻松点，至少培训机构会帮你们制定好方向。但是自学其实会给公司留下不错的印象，公司会觉得你的学习能力不错，同时自学也很锻炼人，对你以后的成长有帮助。<br/><br/>我只能帮你们分析，你们可以根据自己的情况去选择。但是，我觉得如果你无法靠自学进入这一行，你以后的路可能也会走得比较艰难。<br/><br/>5、算法是否重要？<br/><br/>答：对于0基础自学的同学来说，算法的地位可以稍微放后面一点，当前的目标还是先打好 Java 基础，能写 Java 代码。<br/><br/>6、是否应该先学 C 语言？<br/><br/>答：说实话，我个人并不建议，虽然 C 语言确实是挺重要的，但是我觉得如果有这个时间，还不如把 Java 基础多巩固一下。<br/><br/>7、初中/高中/中专学历能不能自学 Java？<br/><br/>答：网上可能有很多人/机构说学历不重要啊，balabala。但是负责任的说，学历还是很重要的，我不是很推荐这些同学自学 Java，因为真的比较难，就算学会了也困难重重，很多企业都有学历限制。<br/><br/>目前来看，至少要有大专学历，最好有本科，否则建议还是仔细考虑下，除非你确实已经走投无路了。<br/><br/>8、大龄转行自学 Java 是否可行？<br/><br/>答：跟学历一样，大龄在这个行业也是个问题，如果现在有工作，我建议可以先用业余时间学看看，但是不要轻易辞职自学，风险很大。<br/><br/>9、看书学习快，还是看视频学习快呢？<br/><br/>答：视频。自学阶段的小白看书效率很低，基本是看不下去的，不推荐看书，可以后续学习的差不多了，看点入门的书籍辅助。初学阶段主要看视频，然后辅助看一些网上入门的博文。<br/><br/>10、为什么不能看书，我有时候看了一上午视频就感觉很浮躁，下午去教室看书不行吗？<br/><br/>答：因为本文还是主要按大多数人的学习情况来写，所以正常会推荐新手看视频，但是如果视频有时候看不下去，想尝试下看书，我觉得也是可以的，但是如果看书看不下去后，说明不合适，就不要继续坚持了，还是看视频为主。<br/><br/>看书的话，《Java编程思想》我肯定是不推荐的，这本书我自己当时看过，效果不好，不推荐。<br/><br/>目前看来对于初学者，评价比较好的是：《Java核心技术·卷 I 基础知识》，这本书我自己没看过，但是我看有好几个正在自学的同学推荐看，然后本身评价也不错，所以想看书的同学建议可以入这本书试试。<br/><br/>11、有不少大一新生表示看不懂？<br/><br/>答：大一新生看不懂，我觉得是正常的，也不需要急，因为你们所处的时间点还是很早的，只要现在抓紧时间，按本文的路线去学习，到大三应该就学的差不多了，后面还有时间去学学进阶的知识。后面毕业后，你们会发现你们的优势是比较大的。<br/><br/>12、好多东西听不懂，还有好多词看了后就忘了，不知道具体是啥意思，搞的越来越懵了？<br/><br/>答：这个是初学者正常都会遇到的，不需要很慌张，没有什么捷径，就是多看、多敲、多练，久而久之用多了，就记住了。<br/><br/>福利<br/>文章提到的知识点，我在B站找了一些当前点击量和评价比较不错的教程，简单的整理了一份“0 基础 Java 自学之路（配套教程）”，需要的微信搜索：程序员囧辉，在菜单栏 “自学教程” 自行获取即可。<br/><br/>如果觉得不合适，也可以按文中“自学教程获取”提到的方法去自己寻找合适的，也是可以的。<br/><br/>最后<br/>如果你的问题没有在本文提到，或者你对本文有疑问，你可以在文章下方留我留言，对于每个留言我基本都会在24小时内回复，极端情况下可能会放到周末回复，原则上只要是与本文相关的正常留言我都会回复。<br/><br/>对于评论里的题目，如果是很多人关注的，我在后续会添加到文章的“常见问题”里。<br/>', '[]', 3, 1, 1, 1, '2023-11-01 16:05:49', '2023-11-12 00:35:00'),
(3, '数据库学习教程（一、初识数据库）', '一、初识数据库<br/><br/>1.1、什么是数据库<br/>数据库：DB（DataBase）<br/>概念：数据仓库，软件，安装在操作系统之上<br/>作用：存储数据，管理数据<br/><br/>1.2、数据库分类<br/>关系型数据库：SQL（Structured Query Language）<br/>MySQL、Oracle、Sql Server、DB2、SQLlite<br/>通过表和表之间，行和列之间的关系进行数据的存储<br/>通过外键关联来建立表与表之间的关系<br/>非关系型数据库：NoSQL（Not Only SQL）<br/>Redis、MongoDB<br/>指数据以对象的形式存储在数据库中，而对象之间的关系通过每个对象自身的属性来决定<br/><br/>1.3、相关概念<br/>DBMS（数据库管理系统）<br/>数据库的管理软件，科学有效的管理、维护和获取我们的数据<br/>MySQL就是数据库管理系统<br/><br/><br/>1.4、MySQL及其安装<br/>MySQL最新版8.0.21安装配置教程~<br/>1.5、基本命令<br/>所有的语句都要以分号结尾<br/>show databases;	--查看当前所有的数据库<br/>use 数据库名;	--打开指定的数据库<br/>show tables;	--查看所有的表<br/>describe/desc 表名;	--显示表的信息<br/>create database 数据库名;	--创建一个数据库<br/>exit	--退出连接', '[]', 4, 6, 0, 1, '2023-11-01 16:06:36', '2023-11-12 00:35:28'),
(4, '关于物理学', '物理学（physics）是研究物质、能量的本质与性质的自然科学。由于物质与能量是所有科学研究的必须涉及的基本要素，所以物理学是自然科学中最基础的学科之一。物理学是一种实验科学，物理学者从观测与分析大自然的各种基于物质与能量的现象来找出其中的模式。这些模式称为“物理理论”，经得起实验检验的常用物理理论称为物理定律，直到有一天被证明是有错误为止(具可否证性)。物理学是由这些定律精致地建构而成。物理学是自然科学中最基础的学科之一。化学、生物学、考古学等等科学学术领域的理论都是建构于这些物理定律。<br/><br/><br/>（从左上角起，顺时针方向）1.折射光；2.一束激光；3.热气球；4.陀螺；5.非弹性碰撞；6.氢的原子轨道；7原子弹爆炸；8.闪电；9.星系<br/>物理学是最古老的学术之一。物理学、化学、生物学等等原本都归属于自然哲学的范畴，直到十七世纪至十九世纪期间，才渐渐地从自然哲学中分别成长为独立的学术领域。[4]:193-194物理学与其它很多跨领域研究有相当的交集，如量子化学、生物物理学等等。物理学的疆界并不是固定不变的，物理学里的创始突破时常可以用来解释这些跨领域研究的基础机制，有时还会开启崭新的跨领域研究。<br/><br/>通过创建新理论与发展新科技，物理学对于人类文明有极为显著的贡献。例如，由于电磁学的快速发展，电灯、电动机、家用电器等新产品纷纷涌现，人类社会的生活水平也得到大幅提升。由于核子物理学日趋成熟，核能发电已不再是蓝图构想，但其所引致的安全问题也使人们意识到地球环境、生态与人类的娇弱渺小。', '[]', 4, 5, 2, 1, '2023-11-01 16:08:41', '2023-11-12 00:35:43'),
(5, '数学的分支', '1. 数学史<br/><br/>2. 数理逻辑与数学基础<br/>a：演绎逻辑学（也称符号逻辑学），b：证明论（也称元数学），c：递归论，d：模型论，e：公理集合论，f：数学基础，g：数理逻辑与数学基础其他学科。<br/><br/>3. 数论<br/>a：初等数论，b：解析数论，c：代数数论，d：超越数论，e：丢番图逼近，f：数的几何，g：概率数论，h：计算数论，i：数论其他学科。<br/><br/>4. 代数学<br/>a：线性代数，b：群论，c：域论，d：李群，e：李代数，f：Kac-Moody代数，g：环论（包括交换环与交换代数，结合环与结合代数，非结合环与非结合代数等），h：模论，i：格论，j：泛代数理论，k：范畴论，l：同调代数，m：代数K理论，n：微分代数，o：代数编码理论，p：代数学其他学科。<br/><br/>5. 数学分析<br/>a：微分学，b：积分学，c：级数论，d：数学分析其他学科。<br/><br/>6. 非标准分析<br/><br/>7. 函数论<br/>a：实变函数论，b：单复变函数论，c：多复变函数论，d：函数逼近论，e：调和分析，f：复流形，g：特殊函数论，h：函数论其他学科。<br/><br/>8. 常微分方程<br/>a：定性理论，b：稳定性理论。c：解析理论，d：常微分方程其他学科。<br/><br/>9. 偏微分方程<br/>a：椭圆型偏微分方程，b：双曲型偏微分方程，c：抛物型偏微分方程，d：非线性偏微分方程，e：偏微分方程其他学科。<br/><br/>10. 动力系统<br/>a：微分动力系统，b：拓扑动力系统，c：复动力系统，d：动力系统其他学科。<br/><br/>11. 积分方程<br/><br/>12. 泛函分析<br/>a：线性算子理论，b：变分法，c：拓扑线性空间，d：希尔伯特空间，e：函数空间，f：巴拿赫空间，g：算子代数 h：测度与积分，i：广义函数论，j：非线性泛函分析，k：泛函分析其他学科。<br/><br/>13. 计算数学<br/>a：插值法与逼近论，b：常微分方程数值解，c：偏微分方程数值解，d：积分方程数值解，e：数值代数，f：连续问题离散化方法，g：随机数值实验，h：误差分析，i：计算数学其他学科。<br/><br/>14. 几何学<br/>a：几何学基础，b：欧氏几何学，c：非欧几何学（包括黎曼几何学等），d：球面几何学，e：向量和张量分析，f：仿射几何学，g：射影几何学，h：微分几何学，i：分数维几何，j：计算几何学，k：几何学其他学科。<br/><br/>15. 代数几何学<br/><br/>16. 拓扑学<br/>a：点集拓扑学，b：代数拓扑学，c：同伦论，d：低维拓扑学，e：同调论，f：维数论，g：格上拓扑学，h：纤维丛论，i：几何拓扑学，j：奇点理论，k：微分拓扑学，l：拓扑学其他学科。<br/><br/>17. 图论<br/><br/>18. 组合数学<br/><br/>19. 概率论<br/>a：几何概率，b：概率分布，c：极限理论，d：随机过程（包括正态过程与平稳过程、点过程等），e：马尔可夫过程，f：随机分析，g：鞅论，h：应用概率论（具体应用入有关学科），i：概率论其他学科。<br/><br/>20. 数理统计学<br/>a：抽样理论（包括抽样分布、抽样调查等 ），b：假设检验，c：非参数统计，d：方差分析，e：相关回归分析，f：统计推断，g：贝叶斯统计（包括参数估计等），h：试验设计，i：多元分析，j：统计判决理论，k：时间序列分析，l：数理统计学其他学科。<br/><br/>21. 应用统计数学<br/>a：统计质量控制，b：可靠性数学，c：保险数学，d：统计模拟。<br/><br/>22. 应用统计数学其他学科<br/><br/>23. 运筹学<br/>a：线性规划，b：非线性规划，c：动态规划，d：组合最优化，e：参数规划，f：整数规划，g：随机规划，h：排队论，i：对策论（也称博弈论），j：库存论，k：决策论，l：搜索论，m：图论，n：统筹论，o：最优化，p：运筹学其他学科。<br/><br/>24. 模糊数学<br/><br/>25. 量子数学<br/><br/>26. 应用数学（具体应用入有关学科）<br/><br/>27. 数学其他学科', '[https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/article/2f8394a6-8a2a-41cf-b4fd-b645a86fb50c.png]', 4, 4, 0, 1, '2023-11-01 16:13:00', '2023-11-12 00:36:04'),
(6, 'python有哪些好的学习资料或者博客', '推荐Full Stack Python 有各种python资源汇总，从基础入门到各种框架web应用开发和部署，再到高级的ORM、Docker都有。以下是Full Stack Python 上总结的一些教程，我拙劣的翻译了以下，并调整（调整顺序并删了部分内容）了一下：<br/><br/><br/><br/>　1、无开发经验，初学python<br/>　　如果你不会其他语言，python是你的第一门语言：<br/><br/>A Byte of Python （简明python教程，这个有中文版简明 Python 教程）是非常好的入门教程。<br/>Learn Python the Hard Way （Zed Shaw的免费教程，个人强烈推荐）<br/>Python, Django and Flask教程： Real Python （收费，需购买）<br/>short 5 minute video 解释了为什么你的出发点应该是要完成什么项目，或者解决什么问题，而不是为了学一门语言而去学一门语言。<br/>Dive into Python 3 是一本开源的python教程，提供HTML和PDF版。<br/>Code Academy 有一个为纯新手准备的 Python track 。<br/>Introduction to Programming with Python 介绍了基本语法和控制结构等，提供了大量代码示例。<br/>O’Reilly 的书 Think Python: How to Think Like a Computer Scientist 是非常好的入门教材。<br/>Python Practice Book 是一本python练习的书，帮你掌握python基本语法。<br/>想通过做实际项目来学编程？看看这个 this list of 5 programming project for Python beginners（5个适合python初学者的编程项目）。<br/>Reddit的创造者之一写了一个教程，如何用python构建一个博客网站（use Python to build a blog.），使非常好的web编程入门。<br/>The fullstack python的作者写了一篇关于如何学习python的文章learning Python 。<br/>　2、有开发经验 ，初学Python<br/>Learn Python in y minutes ，让你在几分钟内快速上手，有个大概了解。<br/>Python for you and me ， python的语法，语言的主要结构等，还包含来Flask Web App的教程。<br/>The Hitchhiker’s Guide to Python<br/>How to Develop Quality Python Code ，如何开发高质量的python代码<br/>　3、进阶<br/>The Python Ecosystem: An Introduction ， 关于python生态系统，虚拟机、python包管理器pip、虚拟环境virtualenv、还有很多进阶主题<br/>The Python Subreddit ，就是python的reddit节点（相当于中国的贴吧），是一个活跃的社区，可以交流讨论，解决问题等。<br/>Good to Great Python Reads ，收集进阶和高级python文章，讲了很多细微差异和python语言本身的细节。<br/>博客 Free Python Tips ，有很多python和python生态系统的文章。<br/>Python Books ，有一些免费的Python, Django, 数据分析等方面的书。<br/>Python IAQ: Infrequently Asked Questions ，关于python 经常问到的问题。<br/>　4、视频，屏幕录像，演示文稿等<br/>　　一些技术交流会议的视频录像： best Python videos<br/><br/>　5、python的包<br/>awesome-python ，收集了python各种非常好用非常酷的包，确实非常awesome，让作者相见恨晚（ I wish I had this page when I was just getting started）。<br/>easy-python<br/>　6、 播客（Podcasts）<br/>Talk Python to Me ， 关注使用python的人们和组织，每一期都会邀请一些开发者谈谈他们的工作等。<br/>Podcast.__init__ ，关于python和让python更牛B的人们。<br/>　7、新闻资讯（可订阅）<br/>Python Weekly ， 最新的python文章、视频、项目、资讯 。<br/>PyCoder’s Weekly ，和python weekly类似。<br/>Import Python<br/>　　via：zhihu<br/><br/>python基础教程<br/>python基础系列教程——Python的安装与测试：python解释器、PyDev编辑器、pycharm编译器<br/><br/>python基础系列教程——Python库的安装与卸载<br/><br/>python基础系列教程——Python3.x标准模块库目录<br/><br/>python基础系列教程——Python中的编码问题，中文乱码问题<br/><br/>python基础系列教程——python基础语法全解<br/><br/>python基础系列教程——python中的正则表达式全解<br/><br/>python数据分析系列教程——python对象与json字符串的相互转化，json文件的存储与读取<br/><br/>python基础系列教程——python面向对象编程全解<br/><br/>python基础系列教程——数据结构（列表、元组、字典、集合、链表）<br/><br/>python应用教程<br/>python应用系列教程——python使用socket创建udp服务器端和客户端<br/><br/>python应用系列教程——python使用socket创建tcp服务器和客户端<br/><br/>python应用系列教程——python使用SocketServer实现网络服务器，socket实现客户端<br/><br/>python应用系列教程——python使用scapy监听网络数据包、按TCP/IP协议进行解析<br/><br/>python应用系列教程——python使用smtp上传邮件，使用pop3下载邮件<br/><br/>python应用系列教程——python使用smtp协议发送邮件：html文本邮件、图片邮件、文件附件邮件<br/><br/>python应用系列教程——python中ftp操作：连接、登录、获取目录，重定向、上传下载，删除更改<br/><br/>python应用系列教程——python操作office办公软件word<br/><br/>python应用系列教程——python操作office办公软件（excel）<br/><br/>python应用系列教程——python的GUI界面编程Tkinter全解<br/><br/>python后台架构Django教程<br/>python后台架构Django开发全解<br/><br/>python后台架构Django教程——manage.py命令<br/><br/>python后台架构Django教程——项目配置setting<br/><br/>python后台架构Django教程——连接读写mysql数据库<br/><br/>python后台架构Django教程——数据模型Model<br/><br/>python后台架构Django教程——视图views渲染<br/><br/>python后台架构Django教程——templates模板<br/><br/>python后台架构Django教程——路由映射urls<br/><br/>python后台架构Django教程——admin管理员站点<br/><br/>python后台架构Django教程——日志系统<br/><br/>python自动化测试教程<br/>python测试系列教程 —— 单元测试unittest<br/><br/>python测试系列教程 —— 调试日志logging<br/><br/>python测试系列教程——python+Selenium自动化测试框架<br/><br/>python网络爬虫教程<br/>抓包工具Fiddler的使用说明<br/><br/>python网络爬虫系列教程——python中urllib、urllib2、cookie模块应用全解<br/><br/>python网络爬虫系列教程——python中pyquery库应用全解<br/><br/>python网络爬虫系列教程——python中lxml库应用全解（xpath表达式）<br/><br/>python网络爬虫系列教程——python中requests库应用全解<br/><br/>python网络爬虫系列教程——python中BeautifulSoup4库应用全解<br/><br/>python网络爬虫系列教程——PhantomJS包应用全解<br/><br/>python网络爬虫系列教程——Scrapy框架应用全解<br/><br/>python网络爬虫系列教程——Python+PhantomJS +Selenium组合应用<br/><br/>python网络爬虫系列教程——python网络数据爬虫误区，让你的爬虫更像人类<br/><br/>python数据分析存储教程<br/>python数据分析系列教程——NumPy全解<br/><br/>python数据分析系列教程——Pandas全解<br/><br/>python数据存储系列教程——xls文件的读写<br/><br/>python数据存储系列教程——python对象与json字符串的相互转化，json文件的存储与读取<br/><br/>python数据存储系列教程——python（pandas）读写csv文件<br/><br/>python数据存储系列教程——python操作sqlite数据库：连接、增删查改、指令执行<br/><br/>python数据存储系列教程——python中mysql数据库操作：连接、增删查改、指令执行<br/><br/>python数据存储系列教程——python中mongodb数据库操作：连接、增删查改、多级路径<br/><br/>python可视化教程<br/>python数据可视化系列教程——matplotlib绘图全解<br/><br/>python爬虫助手<br/>各大网站RSS订阅源地址<br/><br/>腾讯股票接口、和讯网股票接口、新浪股票接口、雪球股票数据、网易股票数据<br/><br/>抓包工具Fiddler的使用说明<br/><br/>python爬虫案例<br/>python爬虫案例——csdn数据采集<br/><br/>python爬虫案例——糗事百科数据采集<br/><br/>python爬虫案例——百度贴吧数据采集<br/><br/>python爬虫案例——爬取西刺免费代理服务器IP等信息<br/><br/>python爬虫案例——东方财富股票数据采集<br/><br/>python爬虫案例——证券之星股票数据采集<br/><br/>python爬虫案例——新浪腾讯股票数据采集<br/><br/>python爬虫案例系列教程——根据网址爬取中文网站，获取标题、子连接、子连接数目、连接描述、中文分词列表<br/><br/>python爬虫案例系列教程——python爬取百度新闻RSS数据<br/><br/>python机器学习算法案例<br/>机器学习书籍推荐<br/><br/>人工智能、机器学习、深度学习、数据挖掘、数据分析区分<br/><br/>数据挖掘工程师知识体系<br/><br/>特征工程：<br/><br/>python机器学习案例系列教程——GBDT构建新特征<br/><br/>关联挖掘：<br/><br/>python机器学习案例系列教程——关联分析（Apriori、FP-growth）<br/><br/>分类：<br/><br/>python机器学习案例系列教程——决策树（ID3、C4.5、CART）<br/><br/>python机器学习案例系列教程——基于规则的分类器<br/><br/>python机器学习案例系列教程——K最近邻算法(KNN)、kd树<br/><br/>python机器学习案例系列教程——极大似然估计、EM算法<br/><br/>python机器学习案例系列教程——文档分类器，朴素贝叶斯分类器，费舍尔分类器<br/><br/>python机器学习案例系列教程——优化，寻找使成本函数最小的最优解<br/><br/>python机器学习案例系列教程——线性函数、线性回归、正则化<br/><br/>python机器学习案例系列教程——逻辑分类/逻辑回归/一般线性回归<br/><br/>python机器学习案例系列教程——支持向量机SVM、核方法<br/><br/>python机器学习案例系列教程——集成学习（Bagging、Boosting、RF、AdaBoost、GBDT、xgboost）<br/><br/>python机器学习案例系列教程——GBDT算法、XGBOOST算法<br/><br/>python机器学习案例系列教程——CTR/CVR中的FM、FFM算法<br/><br/>python机器学习案例系列教程——LightGBM算法<br/><br/>聚类：<br/><br/>python机器学习案例系列教程——层次聚类<br/><br/>python机器学习案例系列教程——BIRCH聚类<br/><br/>python机器学习案例系列教程——k均值聚类、k中心点聚类<br/><br/>python机器学习案例系列教程——DBSCAN密度聚类<br/><br/>[python机器学习案例系列教程——网格聚类]<br/><br/>python机器学习案例系列教程——聚类算法总结<br/><br/>推荐系统：<br/><br/>python机器学习案例系列教程——推荐系统<br/><br/>搜索引擎：<br/><br/>python数据挖掘案例系列教程——python神经网络实现搜索引擎<br/><br/>图论： <br/>python机器学习案例系列教程——最小生成树（MST）的Prim算法和Kruskal算法<br/><br/>机器学习总结<br/>机器学习案例系列教程——算法总结<br/><br/>机器学习案例系列教程——损失函数总结<br/><br/>机器学习案例系列教程——优化方法总结（梯度下降法、牛顿法、拟牛顿法、共轭梯度法等）<br/><br/>机器学习案例系列教程——距离度量方法总结<br/><br/>机器学习案例系列教程——模型评估总结<br/><br/>python机器学习库教程<br/>python机器学习系列教程——深度学习框架比较TensorFlow、Theano、Caffe、SciKit-learn、Keras<br/><br/>python机器学习库xgboost——xgboost算法<br/><br/>python自然语言处理库教程<br/>NLP自然语言处理库系列教程——结巴中文分词<br/><br/>NLP自然语言处理库系列教程——gensim库<br/><br/>python机器学习库sklearn教程<br/>python机器学习库sklearn——生成样本数据<br/><br/>python机器学习库sklearn——数据预处理<br/><br/>python机器学习库sklearn——特征提取<br/><br/>python机器学习库sklearn——特征选择<br/><br/>python机器学习库sklearn——K最近邻、K最近邻分类、K最近邻回归<br/><br/>python机器学习库sklearn——决策树<br/><br/>python机器学习库sklearn——k均值聚类<br/><br/>python机器学习库sklearn——BIRCH聚类<br/><br/>python机器学习库sklearn——DBSCAN密度聚类<br/><br/>python机器学习库sklearn——文档贝叶斯分类器<br/><br/>python机器学习库sklearn——线性回归<br/><br/>python机器学习库sklearn——岭回归（Ridge、RidgeCV）（L2正则化）<br/><br/>python机器学习库sklearn——Lasso回归（L1正则化）<br/><br/>python机器学习库sklearn——逻辑分类<br/><br/>python机器学习库sklearn——支持向量机svm<br/><br/>python机器学习库sklearn——SGD梯度下降法<br/><br/>python机器学习库sklearn——降维<br/><br/>python机器学习库sklearn——神经网络（分类、回归）<br/><br/>python机器学习库sklearn——集成方法（Bagging、Boosting、随机森林RF、AdaBoost、GBDT）<br/><br/>python机器学习库sklearn——多类、多标签、多输出<br/><br/>python机器学习库sklearn——参数优化（网格搜索GridSearchCV、随机搜索RandomizedSearchCV）<br/><br/>python机器学习库sklearn——交叉验证（K折、留一、留p、随机）<br/><br/>python机器学习库sklearn——模型度量<br/><br/>python深度学习系列教程<br/>零基础入门深度学习(1) - 感知器<br/><br/>零基础入门深度学习(2) - 线性单元和梯度下降<br/><br/>零基础入门深度学习(3) - 神经网络和反向传播算法<br/><br/>零基础入门深度学习(4) - 卷积神经网络<br/><br/>零基础入门深度学习(5) - 循环神经网络<br/><br/>零基础入门深度学习(6) - 长短时记忆网络(LSTM)<br/><br/>零基础入门深度学习(7) - 递归神经网络<br/><br/>python深度学习案例教程<br/>python神经网络案例——FC全连接神经网络实现mnist手写体识别<br/><br/>python神经网络案例——CNN卷积神经网络实现mnist手写体识别<br/><br/>python深度学习库tensorflow教程<br/>python深度学习库tensorflow——实现FC全连接神经网络识别mnist手写体<br/><br/>python深度学习库keras教程<br/>python深度学习库keras——安装<br/><br/>python深度学习库keras——各类网络层<br/><br/>python深度学习库keras——网络建模<br/><br/>python深度学习库keras实例教程<br/>python机器学习库keras——线性回归、逻辑回归、一般逻辑回归<br/><br/>python机器学习库keras——CNN卷积神经网络识别手写体<br/><br/>python机器学习库keras——CNN卷积神经网络人脸识别<br/><br/>python机器学习库keras——AutoEncoder自编码、特征压缩<br/><br/>python深度学习库教程<br/>python深度学习库系列教程——python调用opencv库教程<br/><br/>python分布式计算hadoop+hive+hbase+spark教程<br/>hadoop、hbase、hive、spark分布式系统架构原理<br/><br/>centos7下搭建hadoop、hbase、hive、spark分布式系统架构<br/><br/>hadoop+hive+hbase+spark补充内容<br/><br/>spark 常用函数介绍（python）<br/><br/>shell编程<br/><br/>sql优化的几种方法<br/><br/>Hbase数据结构+基本语法<br/><br/>Hadoop Hive sql 语法详解', '[https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/article/9203d3ec-9254-4b13-88c8-d0e89823717e.png]', 3, 2, 1, 1, '2023-11-01 16:13:39', '2023-11-12 00:36:21'),
(7, 'c++基础篇', '前沿：<br/><br/>        c++作为目前比较的流行的语言之一，在就业上也是运用比较广泛的语言之一，并且经过这么多年的历练久经不衰，所以说选择学c++是一个不错的选择^_^，前面看到一个段子，如何在21天精通c++，我动态里有这张图片，一个努力的程序员经过几年的磨练也只能说是熟悉c++，对于语言的学习并不可能有速成班，都是不断的积累，c++也是如此，但相比较c语言，c++的语法特性繁琐复杂，知识点比较琐碎，它是对c语言一些缺陷的完善，并且保留c语言的所有特性，也就是c语言能用的在c++中也能实现，在学习过程中，一定要做好总结和思维导图的构建，把每个知识进行良好的串联在一起，才能熟悉的运用它，而本篇博客也只是初步的认识一下c++,只能让你浅浅的进入新手<br/><br/>目录<br/><br/> 一、命名空间：<br/><br/>1.1命名空间存在的意义：<br/><br/>1.2命名空间的定义：<br/><br/>1.3命名空间的使用：<br/><br/>二、c++的输入与输出：<br/><br/>2.1第一个c++函数:<br/><br/>2.2c++的输入与输出：<br/><br/>三、缺省参数：<br/><br/>3.1缺省参数的定义：<br/><br/>3.2省参数的分类：<br/><br/>四、函数重载：<br/><br/>4.1函数重载的意义：<br/><br/>4.2函数重载的概念：<br/><br/>4.3函数重载的列举：<br/><br/>五、引用：<br/><br/>5.1引用的概念：<br/><br/>5.2引用的特性：<br/><br/>5.3引用的应用：<br/><br/>5.5引用和指针的区别：<br/><br/>六、内联函数：<br/><br/>6.1内敛函数存在的意义：<br/><br/>6.2内敛函数的定义：<br/><br/>6.3内敛函数特性:<br/><br/>总结：<br/><br/> <br/><br/> 一、命名空间：<br/>1.1命名空间存在的意义：<br/>         1.1.1要知道c++是对c语言缺点的完善，而在c语言中我们是知道，定义变量、函数名或者全域名是不能相同的，否则会产生冲突，但要知道这都是大量存在的，就像一个名字也有很多重名，一个项目，每个人负责不同的模块，也避免不了名字相同（因为我不知道你也用了这个名字），在c语言中就会产生冲突，而且在全域中也可能和库函数中名字相同例如：<br/><br/> #include<stdio.h><br/> #include<stdlib.h><br/> int rand=10;//编译后后报错：error C2365: “rand”: 重定义；以前的定义是“函数<br/> int main()<br/>{<br/> <br/>   printf(\"%d\\n\",rand);<br/>      return 0;<br/>}<br/>这里编译错误在c语言中就是没办法避免的，所以c语言编译就要避免和c语言库里函数名相同，这是很麻烦的，要知道我们并不能知道所有库函数，而c++命名空间的存在就解决了这个问题。<br/><br/>1.2命名空间的定义：<br/>        1.2.1命名空间的定义要用到一个关键字就是namespace加命名空间的名字，然后接一个{ },里面就是命名空间的成员。<br/><br/> //这我定义的名字为xiaoma<br/>namespace xiaoma<br/>{<br/>  //可以定义变量也可以定义函数<br/>   int rand =10;<br/>   int Add(int x,int y)<br/>   {<br/>         return x+y;<br/>   }<br/> <br/>        //同时也可以进行嵌套<br/>         namespace hello{   <br/>                     //嵌套在命名空间xiaoma的命名空间hello<br/>                       //不同命名空间里的名字可以相同<br/>                int rand=20;<br/>            int Add(int x,int y)<br/>               {<br/>                    return x+Y;<br/>                }<br/> <br/> <br/>                        }<br/> <br/>}<br/><br/>1.3命名空间的使用：<br/>        1.3.1命名空间中的成员并不能直接使用，有三种形式使用方式：<br/><br/><1>加命名空间名称以及作用域符号：<br/><br/> namespace xiaoma<br/>{<br/>         int a=10;<br/>         int b=20;<br/>}<br/>int main()<br/>{<br/>      //  printf(\"%d\\n\",a) 这种是错误的不能直接使用<br/>          printf(\"%d\\n\",xiaoma::a);<br/>          printf(\"%d\\n\",xiaoma::b);<br/>        return 0;<br/>}<br/><2>使用using将命名空间某个成员引入：<br/><br/> namespace xiaoma<br/>{<br/>         int a=10;<br/>         int b=20;<br/>}<br/>usinng xiaoma::a;<br/>int main()<br/>{<br/>      //  printf(\"%d\\n\",a) 这种是错误的不能直接使用<br/>          printf(\"%d\\n\",a); //这个已经被引入了所以可以直接用<br/>          printf(\"%d\\n\",xiaoma::b);<br/>        return 0;<br/>}<br/><3>使用using namespace命名空间的引入<br/><br/>namespace xiaoma<br/>{<br/>         int a=10;<br/>         int b=20;<br/>}<br/>usinng  namespace xiaoma;<br/>int main()<br/>{<br/>        printf(\"%d\\n\",a); <br/>        printf(\"%d\\n\",b);<br/>        return 0;<br/>}<br/>二、c++的输入与输出：<br/>2.1第一个c++函数:<br/>    2.1.1就像学习c语言一样，我们学习c++也们也来写第一个c++函数。<br/><br/>#include<iostream><br/>using namespace std;<br/>int main()<br/>{<br/>        cout<<\"Hello World\"<<endl; //endl表示换行的意思<br/>           return 0;<br/>}<br/>2.2c++的输入与输出：<br/>#include<iostream><br/>using namespace std;<br/>int main()<br/>{<br/>        int a;<br/>        double b;<br/>        char c;<br/>         //可以自动识别变量类型<br/>          cin>>a;<br/>          cin>>b>>c;<br/>          cout<<a<<endl;<br/>           cout<<b<<\' \'<<c<<endl;      <br/>        return 0;<br/>}<br/>    2.2.1cout(输出)和cin (输入）的使用必须包含头文件<iostream>和以及按命名空间使用方法使用std.<br/><br/>    2.2.2<<是流插入运算符，>>是流提取运算符。<br/>    2.2.3std是C++标准库的命名空间,怎么理解呢？他就好比一个围墙，把标准库全放放在里面，而我们要访问，就需要透过围墙来进行访问。<br/>三、缺省参数：<br/>3.1缺省参数的定义：<br/>3.1.1缺省参数是声明或定义函数时为函数的参数指定一个缺省值。在调用该函数时，如果没有指定实，参则采用该形参的缺省值，否则使用指定的实参。<br/><br/>#include<iostream><br/>using namespace std;<br/>int Add(int x=10,int y=20)<br/>{<br/>    return x+y;<br/>}<br/>int main()<br/>{<br/>    <br/>    int ret1=Add();  //不穿参数，使用形参默认值<br/>    cout<<ret1<<endl;<br/>    int ret2=Add(1,2)  //穿参数，使用指定实参<br/>    cout<<ret2<<endl;<br/>    return 0;<br/>}<br/>3.2省参数的分类：<br/>3.2.1全缺省参数：<br/><br/>#include<iostream><br/>using namespace std;<br/>int Add(int x=10,int y=20,int z=30)<br/>{<br/>    return x+y+z;<br/>}<br/>int main()<br/>{<br/>    <br/>    int ret1=Add(); //可以不传参数<br/>    int ret2=Add(1); //可以传一个参数<br/>    int ret3=Add(1,2); //可以传两个参数<br/>    int ret4=Add(1,2,3); //可以传三个参数<br/>    //但不能像Add(,2,3)或者这样Add(1,,3)传参，必须是从左到右连续滴传参。<br/>          cout<<ret1<<endl<<ret2<<endl<<ret3<<endl<<ret4<<endl;<br/>}<br/><br/>3.2.2半省参数：<br/><br/>#include<iostream><br/>using namespace std;<br/>int Add(int x,int y=20,int z=30)<br/>{<br/>    return x+y+z;<br/>}<br/> //半省参数必须从右向左依次赋值<br/>int Add1(int x,int y,int z=30)<br/>{<br/>    return x+y+z;<br/>}<br/>//上面两种都是可以的<br/>//但不能中间间隔例如：int Add(int x=10,int y,int z=30)<br/>//或者这样也是不行的 int Add(int x=10,int y,int z)<br/>int main()<br/>{<br/>    int ret1=Add(1,2,3);//可以<br/>    int ret2=Add(1,2);//可以<br/>    int ret3=Add(1);//可以<br/>   // int ret4=Add(); 不可以的x需要传参<br/>同样滴<br/>      int ret5 =Add1(1,2,3);//可以<br/>      int ret6=Add(1,2);//可以<br/>     //  int ret7=Add(1); 不可以因为y没有传参<br/> <br/>  //半缺省参数是要赋值的<br/> <br/>    return 0;<br/>}<br/><br/>四、函数重载：<br/>4.1函数重载的意义：<br/>      4.1.1在日常生活中我们也经常遇到一个词表达不同的意思，例如中国的体育项目的两大极端：<br/><br/>乒乓球和足球一个是“谁也赢不了”另一个也是“谁也赢不了”相同的词表达这不同的意思，c++中的重载也在此体现来。<br/><br/>4.2函数重载的概念：<br/>      4.2.1是函数的一种特殊情况，C++允许在同一作用域中声明几个功能类似的同名函数，这<br/><br/>些同名函数的形参列表（参数个数或类型或类型顺序）不同，常用来处理实现功能类似数据类型<br/>不同的问题。<br/>4.3函数重载的列举：<br/>#include<iostream><br/>using namespace std;<br/>int Add(int x,int y,int z)<br/>{<br/>       return x+y+z;<br/>}<br/>//参数个数不同<br/>int Add(int x,int y)<br/>{<br/>       return x+y;<br/>}<br/>//参数类型不同<br/>double  Add(double x,double y)<br/>{<br/>       return x+y;<br/>}<br/>//参数顺序不同<br/>double  Add(int x,double y)<br/>{<br/>       return x+y;<br/>}<br/>double  Add(double y, int x)<br/>{<br/>       return x+y;<br/>}<br/>int main()<br/>{<br/>     int  ret =Add(1,2,3);<br/>     int  ret1=Add(1,2);<br/>     double   ret2=Add(1.2,2.2);<br/>     double   ret3=Add(1,1.2);<br/>     double   ret4=Add(1.2,1);  //函数重载的作用就是一个函数可以实行多种功能<br/>    cout<<ret<<endl<<ret1<<endl<<ret2<<endl<<ret3<<endl<<ret4<<endl;<br/>    return 0;<br/>}<br/><br/>五、引用：<br/>5.1引用的概念：<br/>   5.1.1引用比较好理解啦，就是给你原有的变量去了一个别名，例如在生活中你的外号，就像叫我小马一样都是别名的意思，编译器不会给引用变量开辟新的内存，他和他引用的变量公用同一个内存空间。<br/><br/>#include<iostream><br/>using namespace std;<br/>int main()<br/>{<br/>    int a=10;<br/>    int& ra=a;<br/>    printf(\"%p\\n\",&a);  //打印a的地址<br/>    printf(\"%p\\n\",&ra);    //打印ra的地址 两个地址是相同的 <br/>     return 0;<br/>}<br/>5.2引用的特性：<br/><1>引用变量必须初始化。 就像你给一个人起小名要有对象呀<br/><br/><2>一个变量可以有多个引用。  一个人可以有多个外号什么的<br/><br/><3>引用一旦引用一个实体，再也不能引用其他实体。<br/><br/>#include<iostream><br/>using namespace std;<br/>int main()<br/>{<br/>    int a=10;<br/>    int&ra=a; //这是引用的初始化<br/>    // int&ra; //这里没有初始化是不正确的。<br/>    int& rb=a; //一个变量可以有多个引用<br/>    <br/>    return 0;<br/>}<br/>5.3引用的应用：<br/>      5.3.1引用做参数：<br/><br/>    通过引用的概念我们可以知道引用是和他的引用变量用同一个地址，所以改变引用就是改变他所引用的变量，就像夸小马文章写的好不就是在夸我吗^ _ ^。<br/><br/>#include<iostream><br/>using namespace std;<br/>void swap(int& x,int& y)<br/>{<br/>    int tmp=0;<br/>    tmp=x;<br/>    x=y;<br/>    y=tmp;<br/>}<br/>int main()<br/>{<br/>    int x=10;<br/>    int y=20;<br/>    swap(x,y);<br/>    cout<<x<<\' \'<<y<<endl;<br/>    return 0;<br/>}<br/><br/>5.3.2引用做返回值：<br/><br/>#include<iostream><br/>using namespace std;<br/>int& Add(int x,int y)<br/>{<br/>    static int ret=x+y; //想想这里为什么用static<br/>    return ret;<br/>}<br/>int main()<br/>{<br/>   int ret=Add(1,2);<br/>    cout<<ret<<endl;<br/>    return 0;<br/>}<br/>      在这里我们想一下为什么要用static 要是不用static的后果是什么呢？ 在我们讲函数栈帧的创建和销毁的时候已经知道，局部变量是储存在栈区的，而栈区是随着函数调用结束后是会被销毁的， 但引用是和引用对象一个地址的，static是把局部变量从栈区存放到静态区，这样随着函数的调用结束后不会被销毁，因此返回的时候还能够找到，要是不用static当返回去寻找的时候是找到的就会是随机值。就好比你住个酒店，而当你退房了之后，发现你的包裹没有拿，而当你返回去的时候，你就无法确定你的包裹还在，他可能还在就是没有被收拾，但有可能你住的酒店已经被其他用户住给扔掉了，这都是有可能的，而static就是把包放在一个储存的东西的地方，你再去这个地方拿就行了。<br/><br/>5.5引用和指针的区别：​​​​​​​<br/>5.5.1引用就是引用对象的一个别名，而指针是变量的地址/<br/><br/>5.5.2引用必须初始化，而地址不需要初始化。<br/><br/>5.5.3引用在初始化一个引用对象后就不能在引用其他变量了，而指针确可以在任何时候指向同类型的地址。<br/><br/>5.5.4引用自身加一是引用对象加一，而指针加一则是地址加一。<br/><br/>5.5.5指针有多级指针，而引用没有<br/><br/>六、内联函数：<br/>6.1内敛函数存在的意义：<br/>  在c语言中调用一个函数要经过栈帧的创建和销毁，而当一个函数调用次数过多的时候就会降低程序运行的效率。这里的解决办法是什么呢？在c语言中有一个解决的方法就是宏函数。想必大家也忘了宏函数的写法了，这里我写一个宏函数的代码。<br/><br/>#include<iostream><br/>using namespace std;<br/>#define Add(x,y)   ((x)+(y))<br/>int main()<br/>{<br/>    int ret=Add(1,2);<br/>    cout<<ret<<endl;<br/>    return 0;<br/>}<br/>为什么宏函数解决了效率呢，要知道一个程序运行的完整运行，是有预处理，编译，汇编，链接四个过程的，而宏函数是在预处理已经完成了。但宏函数已经解决了c栈帧创建和销毁的缺点，为什c++还会创建一个内敛函数呢？要知道虽然宏函数解决了效率问题，但它本身也有自身的缺点，我们可以看出宏函数还是很容易写错的，我这个是比较简单的，要是复杂一点就是很容易就写错的，而宏函数因为在预处理就已经结束了，所以是没有办法调试的，并且他也没有类型安全的检查，因此c++就用内敛函数来解决这个问题。<br/><br/>6.2内敛函数的定义：<br/>       6.2.1以inline修饰的函数叫做内联函数，编译时C++编译器会在调用内联函数的地方展开，没有函数调 用建立栈帧的开销，内联函数提升程序运行的效率。<br/>#include<iostream><br/>using namespace std;<br/>inline int Add(int x,int y)<br/>{<br/>     return x+y;<br/>}<br/>int main()<br/>{<br/>    int ret =Add(1,2);<br/>    cout<<ret<<endl;<br/>    return 0;<br/>}<br/>内敛函数和普通函数功能相同就是在函数inline同时也具有了宏函数的一些功能就是不参与编译，在预处理就已经完成了。<br/><br/>6.3内敛函数特性:<br/>      6.3.1  inline是一种以空间换时间的做法，如果编译器将函数当成内联函数处理，在编译阶段，会 用函数体替换函数调用，缺陷：可能会使目标文件变大，优势：少了调用开销，提高程序运<br/>行效率。<br/>      6.3.2  inline对于编译器而言只是一个建议，不同编译器关于inline实现机制可能不同，一般建<br/>议：将函数规模较小(即函数不是很长，具体没有准确的说法，取决于编译器内部实现)、不<br/>是递归、且频繁调用的函数采用inline修饰，否则编译器会忽略inline特性。<br/>      6.3.3 inline不建议声明和定义分离，分离会导致链接错误。因为inline被展开，就没有函数地址<br/>了，链接就会找不到<br/>总结：<br/>     对于这篇文章讲的只是让我们初步的了解认识c++语言，就相当于进入一个新手村才刚刚开始，而c++的脊髓还在后面，就是c++引入类的概念，使c语言的面对过程变为了面对对象，这才是c++魅力所在，而这篇文章让我们可能看的懂一点点简单的c++文章，但浅浅的总结小马也写了5000+字数，对于一些东西还是栈帧的理解深度，所以对于栈帧不理解的伙伴一定要认真看看栈帧，我前篇的文章哈哈哈哈，还有一定要注重思维导图和总结！！', '[]', 3, 3, 0, 1, '2023-11-01 16:20:46', '2023-11-12 00:36:39'),
(8, 'C++命名空间详解', '一个中大型软件往往由多名程序员共同开发，会使用大量的变量和函数，不可避免地会出现变量或函数的命名冲突。当所有人的代码都测试通过，没有问题时，将它们结合到一起就有可能会出现命名冲突。<br/><br/>例如小李和小韩都参与了一个文件管理系统的开发，它们都定义了一个全局变量 fp，用来指明当前打开的文件，将他们的代码整合在一起编译时，很明显编译器会提示 fp 重复定义（Redefinition）错误。<br/><br/>为了解决合作开发时的命名冲突问题，C++ 引入了命名空间（Namespace）的概念。请看下面的例子：<br/>namespace Li{  //小李的变量定义<br/>    FILE* fp = NULL;<br/>}<br/>namespace Han{  //小韩的变量定义<br/>    FILE* fp = NULL;<br/>}<br/>小李与小韩各自定义了以自己姓氏为名的命名空间，此时再将他们的 fp 变量放在一起编译就不会有任何问题。<br/>命名空间有时也被称为名字空间、名称空间。<br/>namespace 是C++中的关键字，用来定义一个命名空间，语法格式为：<br/>namespace name{<br/>    //variables, functions, classes<br/>}<br/><br/>name是命名空间的名字，它里面可以包含变量、函数、类、typedef、#define 等，最后由{ }包围。<br/><br/>使用变量、函数时要指明它们所在的命名空间。以上面的 fp 变量为例，可以这样来使用：<br/>Li::fp = fopen(\"one.txt\", \"r\");  //使用小李定义的变量 fp<br/>Han::fp = fopen(\"two.txt\", \"rb+\");  //使用小韩定义的变量 fp<br/>::是一个新符号，称为域解析操作符，在C++中用来指明要使用的命名空间。<br/><br/>除了直接使用域解析操作符，还可以采用 using 关键字声明，例如：<br/>using Li::fp;<br/>fp = fopen(\"one.txt\", \"r\");  //使用小李定义的变量 fp<br/>Han :: fp = fopen(\"two.txt\", \"rb+\");  //使用小韩定义的变量 fp<br/>在代码的开头用using声明了 Li::fp，它的意思是，using 声明以后的程序中如果出现了未指明命名空间的 fp，就使用 Li::fp；但是若要使用小韩定义的 fp，仍然需要 Han::fp。<br/><br/>using 声明不仅可以针对命名空间中的一个变量，也可以用于声明整个命名空间，例如：<br/>using namespace Li;<br/>fp = fopen(\"one.txt\", \"r\");  //使用小李定义的变量 fp<br/>Han::fp = fopen(\"two.txt\", \"rb+\");  //使用小韩定义的变量 fp<br/>如果命名空间 Li 中还定义了其他的变量，那么同样具有 fp 变量的效果。在 using 声明后，如果有未具体指定命名空间的变量产生了命名冲突，那么默认采用命名空间 Li 中的变量。<br/><br/>命名空间内部不仅可以声明或定义变量，对于其它能在命名空间以外声明或定义的名称，同样也都能在命名空间内部进行声明或定义，例如类、函数、typedef、#define 等都可以出现在命名空间中。<br/><br/>站在编译和链接的角度，代码中出现的变量名、函数名、类名等都是一种符号（Symbol）。有的符号可以指代一个内存位置，例如变量名、函数名；有的符号仅仅是一个新的名称，例如 typedef 定义的类型别名。<br/><br/>下面来看一个命名空间完整示例代码：<br/>#include <stdio.h><br/>//将类定义在命名空间中<br/>namespace Diy{<br/>    class Student{<br/>    public:<br/>        char *name;<br/>        int age;<br/>        float score;<br/>  <br/>    public:<br/>        void say(){<br/>            printf(\"%s的年龄是 %d，成绩是 %f\\n\", name, age, score);<br/>        }<br/>    };<br/>}<br/>int main(){<br/>    Diy::Student stu1;<br/>    stu1.name = \"小明\";<br/>    stu1.age = 15;<br/>    stu1.score = 92.5f;<br/>    stu1.say();<br/>    return 0;<br/>}<br/>运行结果：<br/>小明的年龄是 15，成绩是 92.500000<br/><br/>C++ 命名空间的语法比较复杂，本节所讲到的只是冰山一角，主要是为下节《C++头文件和std命名空间》的讲解打基础。关于命名空间的更多内容我们将在后续章节中一一讲解。', '[https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/article/74aa0468-a614-41ca-9159-cc2a63bb5850.png, https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/article/4fb5c97f-d26b-401c-a5d1-18d40855c784.png, https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/article/99de59c2-ead6-4139-88b3-e3df14f33c15.png, https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/article/3301fd2f-6e8e-49f0-b333-8e91ff88ced6.png, https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/article/a1e873cb-a197-48c7-8037-66309be41d27.png, https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/article/2c689d88-6731-4bcc-995b-172a52a7e374.png]', 4, 3, 2, 1, '2023-11-01 16:21:41', '2023-11-12 00:37:10'),
(9, '求一份Java学习路线', '有没有大佬分享一下', '[https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/article/ed6c2b51-a452-4590-aef6-41e742b2c968.png]', 1, 1, 0, 1, '2023-11-01 17:15:42', '2023-11-12 00:45:38'),
(14, '标题', '内容', '[https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/article/67ca74df-7b5d-49df-9d10-84b64836ee26.png]', 4, 1, 0, 1, '2023-11-12 10:23:12', '2023-11-12 10:23:12');

-- --------------------------------------------------------

--
-- 表的结构 `attention`
--

CREATE TABLE `attention` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fans_id` bigint(20) UNSIGNED NOT NULL COMMENT '关注者ID',
  `attention_id` bigint(20) NOT NULL COMMENT '被关注者ID',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='关注表' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `category`
--

CREATE TABLE `category` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `text` varchar(32) NOT NULL COMMENT '分类昵称',
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '类型:0=文章,1=资源',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态:1=显示,0=隐藏',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分类表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `category`
--

INSERT INTO `category` (`id`, `text`, `type`, `status`, `gmt_create`, `gmt_modified`) VALUES
(1, 'Java', 0, 1, '2023-10-17 12:33:12', '2023-10-17 12:33:12'),
(2, 'Python', 0, 1, '2023-10-17 12:33:26', '2023-10-17 12:33:26'),
(3, 'C/C++', 0, 1, '2023-10-17 12:33:53', '2023-10-17 12:34:11'),
(4, '数学', 0, 1, '2023-10-17 12:34:30', '2023-10-17 12:34:30'),
(5, '物理', 0, 1, '2023-10-17 12:34:49', '2023-10-17 12:34:49'),
(6, '数据库', 0, 1, '2023-10-17 12:35:12', '2023-10-17 12:35:12'),
(7, '前端', 1, 1, '2023-11-07 16:07:24', '2023-11-07 16:07:24'),
(8, '后端', 1, 1, '2023-11-07 16:07:35', '2023-11-07 16:07:35'),
(9, '数据库', 1, 1, '2023-11-07 16:08:01', '2023-11-07 16:08:01'),
(10, '服务端', 1, 1, '2023-11-07 16:08:09', '2023-11-07 16:08:09');

-- --------------------------------------------------------

--
-- 表的结构 `collection`
--

CREATE TABLE `collection` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '集锦名称',
  `description` varchar(255) DEFAULT NULL COMMENT '集锦描述',
  `cover` text COMMENT '集锦封面',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='视频集锦' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `collection`
--

INSERT INTO `collection` (`id`, `title`, `description`, `cover`, `gmt_create`, `gmt_modified`) VALUES
(1, '双体第一期教学', '该系列包含了綦江校区双体第一期的教学视频', NULL, '2023-11-08 18:06:07', '2023-11-08 19:28:36');

-- --------------------------------------------------------

--
-- 表的结构 `comment`
--

CREATE TABLE `comment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cid` bigint(20) UNSIGNED DEFAULT NULL COMMENT '父评论ID',
  `content` text NOT NULL COMMENT '评论内容',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '评论发布者',
  `received_id` bigint(20) UNSIGNED NOT NULL COMMENT '接收者',
  `article_id` bigint(20) UNSIGNED NOT NULL COMMENT '评论文章ID',
  `visit` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否查看:0=未查看,1=已查看',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评论表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `comment`
--

INSERT INTO `comment` (`id`, `cid`, `content`, `user_id`, `received_id`, `article_id`, `visit`, `gmt_create`, `gmt_modified`) VALUES
(2, 0, '评论一下', 1, 3, 2, 1, '2023-11-01 16:11:24', '2023-11-01 16:21:04'),
(3, 0, 'dfbreb\n', 3, 4, 5, 1, '2023-11-01 16:13:55', '2023-11-01 16:24:39'),
(4, 0, '很不错', 1, 4, 8, 1, '2023-11-11 16:21:36', '2023-11-12 10:23:16'),
(5, 0, '很不错', 1, 3, 6, 0, '2023-11-11 16:24:01', '2023-11-11 16:24:01'),
(6, 0, '+1', 4, 4, 5, 1, '2023-11-11 16:46:35', '2023-11-11 16:46:35'),
(7, 0, '懂了', 4, 4, 4, 1, '2023-11-11 16:50:02', '2023-11-11 16:50:02'),
(8, 0, 'pl', 4, 4, 8, 1, '2023-11-12 10:19:53', '2023-11-12 10:19:53');

-- --------------------------------------------------------

--
-- 表的结构 `history`
--

CREATE TABLE `history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `target_id` bigint(20) UNSIGNED NOT NULL COMMENT '访问的资源或文章id',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `type_id` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '类型:0=书籍,1=视频,2=文章',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT '状态:0=删除,1=保存',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='历史记录表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `history`
--

INSERT INTO `history` (`id`, `target_id`, `user_id`, `type_id`, `status`, `gmt_create`, `gmt_modified`) VALUES
(8, 1, 1, 0, 1, '2023-10-27 17:11:17', '2023-11-11 16:36:37'),
(9, 8, 1, 1, 1, '2023-10-27 17:11:23', '2023-11-11 16:36:53'),
(19, 1, 1, 2, 1, '2023-10-27 17:18:35', '2023-10-28 15:28:12'),
(23, 6, 4, 0, 1, '2023-11-01 15:57:49', '2023-11-12 10:13:56'),
(24, 1, 3, 0, 1, '2023-11-01 16:00:03', '2023-11-01 16:00:18'),
(28, 10, 3, 1, 1, '2023-11-01 16:00:27', '2023-11-01 16:00:27'),
(29, 8, 3, 1, 1, '2023-11-01 16:00:35', '2023-11-01 16:00:35'),
(30, 2, 3, 2, 1, '2023-11-01 16:05:52', '2023-11-01 16:10:27'),
(31, 2, 1, 2, 1, '2023-11-01 16:06:11', '2023-11-11 16:38:12'),
(32, 3, 3, 2, 1, '2023-11-01 16:07:13', '2023-11-01 16:08:53'),
(37, 4, 4, 2, 1, '2023-11-01 16:08:48', '2023-11-12 10:10:53'),
(39, 4, 3, 2, 1, '2023-11-01 16:09:14', '2023-11-01 16:09:14'),
(41, 4, 1, 2, 1, '2023-11-01 16:09:56', '2023-11-12 09:30:14'),
(45, 5, 3, 2, 1, '2023-11-01 16:13:49', '2023-11-01 16:13:49'),
(46, 6, 3, 2, 1, '2023-11-01 16:15:36', '2023-11-01 16:15:55'),
(47, 6, 1, 2, 1, '2023-11-01 16:15:48', '2023-11-12 09:29:50'),
(50, 3, 3, 0, 1, '2023-11-01 16:18:04', '2023-11-01 16:18:04'),
(51, 8, 4, 2, 1, '2023-11-01 16:21:45', '2023-11-12 10:20:22'),
(52, 8, 4, 1, 1, '2023-11-01 16:25:45', '2023-11-12 09:39:36'),
(53, 8, 1, 2, 1, '2023-11-01 16:26:02', '2023-11-12 09:53:53'),
(55, 2, 4, 2, 1, '2023-11-01 16:42:08', '2023-11-01 16:42:08'),
(56, 6, 4, 2, 1, '2023-11-01 16:48:51', '2023-11-01 16:49:08'),
(57, 3, 4, 2, 1, '2023-11-01 16:48:58', '2023-11-01 16:48:58'),
(59, 7, 4, 2, 1, '2023-11-01 16:57:23', '2023-11-01 16:57:23'),
(61, 5, 1, 2, 1, '2023-11-01 17:04:43', '2023-11-12 09:29:47'),
(68, 9, 4, 2, 1, '2023-11-01 17:16:02', '2023-11-11 16:17:36'),
(121, 6, 1, 0, 1, '2023-11-07 17:51:56', '2023-11-12 09:45:04'),
(123, 2, 1, 1, 1, '2023-11-08 18:11:12', '2023-11-08 19:28:46'),
(133, 9, 1, 1, 1, '2023-11-08 18:45:17', '2023-11-08 18:45:17'),
(134, 11, 1, 1, 1, '2023-11-08 18:46:22', '2023-11-08 18:46:22'),
(196, 7, 1, 1, 1, '2023-11-08 19:31:07', '2023-11-08 19:31:07'),
(253, 1, 4, 0, 1, '2023-11-11 14:12:37', '2023-11-12 10:21:51'),
(259, 7, 4, 1, 1, '2023-11-11 15:09:52', '2023-11-11 15:09:52'),
(262, 10, 1, 1, 1, '2023-11-11 15:10:25', '2023-11-12 09:41:13'),
(265, 5, 4, 2, 1, '2023-11-11 15:12:16', '2023-11-12 10:10:49'),
(288, 11, 1, 2, 1, '2023-11-11 16:24:28', '2023-11-12 00:17:14'),
(302, 13, 4, 2, 1, '2023-11-11 16:47:13', '2023-11-11 16:47:13'),
(305, 10, 4, 1, 1, '2023-11-11 16:49:21', '2023-11-12 10:11:49'),
(307, 9, 1, 2, 1, '2023-11-12 00:17:10', '2023-11-12 00:17:10'),
(308, 13, 1, 2, 1, '2023-11-12 00:17:12', '2023-11-12 00:17:12'),
(311, 10, 1, 2, 1, '2023-11-12 00:18:35', '2023-11-12 00:18:35');

-- --------------------------------------------------------

--
-- 表的结构 `notebook`
--

CREATE TABLE `notebook` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容HTML',
  `text` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容Text',
  `category_id` bigint(20) UNSIGNED DEFAULT '0' COMMENT '分类',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '所属用户',
  `other_visit` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '允许他人查看:0=否,1=是',
  `other_edit` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '允许他人编辑:0=否,1=是',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='笔记' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `notebook`
--

INSERT INTO `notebook` (`id`, `title`, `content`, `text`, `category_id`, `user_id`, `other_visit`, `other_edit`, `gmt_create`, `gmt_modified`) VALUES
(1, '这是标题', '<p>这是内容</p><h1>一级标题</h1>', '这是内容\n一级标题\n', 0, 1, 0, 0, '2023-11-10 10:54:20', '2023-11-10 10:54:20'),
(15, '数学', '<p>1+1=2</p><blockquote><strong>高数：</strong></blockquote>', '1+1=2\n高数：\n', 0, 4, 0, 0, '2023-11-11 16:20:18', '2023-11-11 16:20:18'),
(20, '添加笔记', '<h1>一级标题</h1><pre class=\"ql-syntax\" spellcheck=\"false\">代码块\n</pre>', '一级标题\n代码块\n', 0, 1, 0, 0, '2023-11-11 16:39:06', '2023-11-11 16:39:06'),
(23, '笔记？', '<pre class=\"ql-syntax\" spellcheck=\"false\">标题\n</pre>', '标题\n', 0, 4, 0, 0, '2023-11-12 10:24:42', '2023-11-12 10:24:42');

-- --------------------------------------------------------

--
-- 表的结构 `notebook_class`
--

CREATE TABLE `notebook_class` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '所属用户',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='笔记分类' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `notebook_class`
--

INSERT INTO `notebook_class` (`id`, `title`, `user_id`, `gmt_create`, `gmt_modified`) VALUES
(1, '编程', 1, '2023-11-10 10:30:37', '2023-11-10 10:34:40'),
(4, '小记', 1, '2023-11-10 10:46:47', '2023-11-10 10:46:47'),
(5, '数学', 4, '2023-11-11 16:19:50', '2023-11-11 16:19:50'),
(6, '数学', 4, '2023-11-11 16:20:55', '2023-11-11 16:20:55'),
(7, '编程', 4, '2023-11-12 10:24:10', '2023-11-12 10:24:10');

-- --------------------------------------------------------

--
-- 表的结构 `resources`
--

CREATE TABLE `resources` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) DEFAULT NULL COMMENT '标题',
  `tabs` varchar(32) DEFAULT NULL COMMENT '标签',
  `author` varchar(32) NOT NULL COMMENT '作者',
  `cover` text NOT NULL COMMENT '封面',
  `description` text NOT NULL COMMENT '简介',
  `path` text NOT NULL COMMENT '资源路径',
  `type` varchar(32) NOT NULL COMMENT '类型',
  `category_id` bigint(20) UNSIGNED DEFAULT '0' COMMENT ' 分类ID',
  `collection_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '集锦ID',
  `episodes` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '集数',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='资源表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `resources`
--

INSERT INTO `resources` (`id`, `title`, `tabs`, `author`, `cover`, `description`, `path`, `type`, `category_id`, `collection_id`, `episodes`, `gmt_create`, `gmt_modified`) VALUES
(1, 'SQL基础教程', 'SQL', 'MICK', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/book/SQL%E5%9F%BA%E7%A1%80%E6%95%99%E7%A8%8B/SQL%E5%9F%BA%E7%A1%80%E6%95%99%E7%A8%8B.png', '本书介绍了关系数据库以及用来操作关系数据库的SQL语言的使用方法，提供了大量的示例程序 和详实的操作步骤说明，读者可以亲自动手解决具体问题，循序渐进地掌握SQL的基础知识和技巧， 切实提高自身的编程能力。在每章结尾备有习题，用来检验读者对该章内容的理解程度。另外本书还 将重要知识点总结为“法则”，方便大家随时査阅。', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/book/SQL%E5%9F%BA%E7%A1%80%E6%95%99%E7%A8%8B/SQL%E5%9F%BA%E7%A1%80%E6%95%99%E7%A8%8B.pdf', 'book', 9, 0, 0, '2023-10-07 16:07:38', '2023-11-08 19:33:15'),
(2, 'HTML(表单)', '前端', '代永亮', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E4%BB%A3%E6%B0%B8%E4%BA%AE/HTML%28%E8%A1%A8%E5%8D%95%29.png', '该视频介绍了HTML表单一些简单应用', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E4%BB%A3%E6%B0%B8%E4%BA%AE/HTML%28%E8%A1%A8%E5%8D%95%29.mp4', 'video', 7, 1, 1, '2023-10-11 16:08:44', '2023-11-08 18:06:25'),
(3, '程序员的数学1', '算法', '佶城浩', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/book/%E7%A8%8B%E5%BA%8F%E5%91%98%E7%9A%84%E6%95%B0%E5%AD%A6/%E7%A8%8B%E5%BA%8F%E5%91%98%E7%9A%84%E6%95%B0%E5%AD%A6.png', '通俗的语言和具体的图表深入讲解程序员必须掌握的 各类概率统计知识，例证丰富，讲解明晰，且提供了大量扩展内容，引导读者进一步深入学习。\n本书涉及随机变量、贝叶斯公式、离散值和连续值的概率分布、协方差矩阵、多元正态分布、估计 与检验理论、伪随机数以及概率论的各类应用，适合程序设计人员与数学爱好者阅读，也可作为高中或 大学非数学专业学生的概率论入门读物。', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/book/%E7%A8%8B%E5%BA%8F%E5%91%98%E7%9A%84%E6%95%B0%E5%AD%A6/%E7%A8%8B%E5%BA%8F%E5%91%98%E7%9A%84%E6%95%B0%E5%AD%A6.pdf', 'book', 0, 0, 0, '2023-10-18 16:26:40', '2023-11-08 19:31:28'),
(4, '程序员的数学2概率统计', '算法', '平冈、幸堀玄', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/book/%E7%A8%8B%E5%BA%8F%E5%91%98%E7%9A%84%E6%95%B0%E5%AD%A62%E6%A6%82%E7%8E%87%E7%BB%9F%E8%AE%A1/%E7%A8%8B%E5%BA%8F%E5%91%98%E7%9A%84%E6%95%B0%E5%AD%A62%E6%A6%82%E7%8E%87%E7%BB%9F%E8%AE%A1.png', '通俗的语言和具体的图表深入讲解程序员必须掌握的 各类概率统计知识，例证丰富，讲解明晰，且提供了大量扩展内容，引导读者进一步深入学习。\n本书涉及随机变量、贝叶斯公式、离散值和连续值的概率分布、协方差矩阵、多元正态分布、估计 与检验理论、伪随机数以及概率论的各类应用，适合程序设计人员与数学爱好者阅读，也可作为高中或 大学非数学专业学生的概率论入门读物。', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/book/%E7%A8%8B%E5%BA%8F%E5%91%98%E7%9A%84%E6%95%B0%E5%AD%A62%E6%A6%82%E7%8E%87%E7%BB%9F%E8%AE%A1/%E7%A8%8B%E5%BA%8F%E5%91%98%E7%9A%84%E6%95%B0%E5%AD%A62%E6%A6%82%E7%8E%87%E7%BB%9F%E8%AE%A1.pdf', 'book', 0, 0, 0, '2023-10-18 16:38:45', '2023-11-08 19:31:41'),
(5, '图解HTTP', '服务端', '上野宣', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/book/%E5%9B%BE%E8%A7%A3HTTP/%E5%9B%BE%E8%A7%A3HTTP.png', '本书内容讲解透彻到位。前半部分由 HTTP的成长发展史娓娓道来，基于HTTP 1.1标准讲解通信过程，包 括HTTP方法、协议格式、报文结构、首部字段、状态码等的具体含 义，还分别讲解HTTP通信过程中代理、网关、隧道等的作用。接着介 绍SPDY、WebSocket. WebDAV等HTTP的扩展功能。作者还从细节 方面举例，让读者更好地理解何为无状态(stateless ). 301和302重定 向的区别在哪、缓存机制，等等。本书后半部分的重心放在Web安全 上，涵盖HTTPS、SSL、证书认证、加密机制、Web攻击手段等内容。', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/book/%E5%9B%BE%E8%A7%A3HTTP/%E5%9B%BE%E8%A7%A3HTTP.pdf', 'book', 0, 0, 0, '2023-10-18 16:41:26', '2023-10-19 18:51:57'),
(6, '写给大家的设计书', '设计', 'Robin Williams', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/book/%E5%86%99%E7%BB%99%E5%A4%A7%E5%AE%B6%E7%9C%8B%E7%9A%84%E8%AE%BE%E8%AE%A1%E4%B9%A6/%E7%BB%99%E5%A4%A7%E5%AE%B6%E7%9C%8B%E7%9A%84%E8%AE%BE%E8%AE%A1%E4%B9%A6.png', '本书严格地说，这不是一本计算机图书，它适用于各行各业与文字打交道的人，你会从中充分 领略到设计之美。复杂的设计原理在这里被浓缩为4个词:.亲密性、对齐、重复和对比，同时作者将这些经 验加以概括并整理，用最简洁凝炼的笔调道出其真谛，读完这本书并遵循了这些基本原则，你的设计看上去会更专业、更有条理、更统一，也更有趣，你会感到自己已经具备了一定的水平', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/book/%E5%86%99%E7%BB%99%E5%A4%A7%E5%AE%B6%E7%9C%8B%E7%9A%84%E8%AE%BE%E8%AE%A1%E4%B9%A6/%E5%86%99%E7%BB%99%E5%A4%A7%E5%AE%B6%E7%9C%8B%E7%9A%84%E8%AE%BE%E8%AE%A1%E4%B9%A6.pdf', 'book', 0, 0, 0, '2023-10-18 16:48:56', '2023-11-08 19:33:30'),
(7, 'CSS', '前端', '苏超', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E8%8B%8F%E8%B6%85/css2.png', '该视频介绍了CSS的相关用法，并带领学生进行相关的操作，帮助更好的理解', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E8%8B%8F%E8%B6%85/CSS%E7%AC%AC%E4%BA%8C%E5%A0%82.mp4', 'video', 7, 1, 2, '2023-10-12 16:54:24', '2023-11-08 18:07:29'),
(8, 'JavaSE(面向对象和异常处理)', 'Java', '苏超', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E8%8B%8F%E8%B6%85/JavaSE.png', '该视频讲解了面向对象的相关知识，包括封装，继承和多态等，以及异常的相关处理', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E8%8B%8F%E8%B6%85/JavaSE-%E7%AC%AC%E4%BA%94%E5%A0%82%28%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1%E5%92%8C%E5%BC%82%E5%B8%B8%E5%A4%84%E7%90%86%29.mp4', 'video', 8, 1, 6, '2023-10-17 16:57:21', '2023-11-08 19:33:36'),
(9, 'JS基础-01', '前端', '苏超', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E8%8B%8F%E8%B6%85/JS-Part3.png', '该视频讲解了JavaScript的相关知识，包括一些对象属性和方法等内容', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E8%8B%8F%E8%B6%85/JS%E5%9F%BA%E7%A1%80-Part3.mp4', 'video', 7, 1, 4, '2023-10-15 17:01:37', '2023-11-08 19:33:09'),
(10, 'JS基础-02', '前端', '苏超', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E8%8B%8F%E8%B6%85/JS-Part4.png', '该视频继《JS基础-Part3》相关视频继续讲解了JavaScript的相关知识', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E8%8B%8F%E8%B6%85/JS%E5%9F%BA%E7%A1%80-Part4.mp4', 'video', 7, 1, 5, '2023-10-14 17:01:39', '2023-11-08 19:33:20'),
(11, '关系数据库', '前端', '苏超', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E8%8B%8F%E8%B6%85/Mysql-Part2.png', '该视频是对Mysql相关知识讲解后的实操内容', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/video/%E8%8B%8F%E8%B6%85/part2-%E5%AE%9E%E6%93%8D.mp4', 'video', 9, 1, 3, '2023-10-13 17:04:13', '2023-11-08 19:33:26');

-- --------------------------------------------------------

--
-- 表的结构 `signboard`
--

CREATE TABLE `signboard` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(500) DEFAULT NULL,
  `image` varchar(255) NOT NULL COMMENT '图片路径',
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '类型:0=轮播图,1=菜单栏',
  `link` text COMMENT '链接',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指示菜单表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `signboard`
--

INSERT INTO `signboard` (`id`, `title`, `image`, `type`, `link`, `gmt_create`, `gmt_modified`) VALUES
(1, '数学', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/carousel/math.png', 0, 'http://match.hoscent.com/community/article?queryId=5', '2023-10-15 21:29:00', '2023-11-12 09:29:35'),
(2, 'python', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/carousel/python.jpg', 0, 'http://match.hoscent.com/community/article?queryId=6', '2023-10-15 21:29:18', '2023-11-12 09:30:02'),
(3, '物理', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/carousel/physics.png', 0, 'http://match.hoscent.com/community/article?queryId=4', '2023-10-15 21:29:32', '2023-11-12 09:30:23'),
(4, 'c', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/carousel/c.png', 0, 'http://match.hoscent.com/community/article?queryId=8', '2023-10-15 21:29:48', '2023-11-12 09:28:22'),
(5, '小智AI', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/menu/robot.png', 1, '/home/chat', '2023-10-15 21:30:46', '2023-10-19 18:45:30'),
(6, '翻译', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/menu/translate.png', 1, NULL, '2023-10-15 21:31:11', '2023-10-19 18:45:17'),
(7, '练习', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/menu/test.png', 1, NULL, '2023-10-15 21:31:36', '2023-10-19 18:45:09');

-- --------------------------------------------------------

--
-- 表的结构 `study`
--

CREATE TABLE `study` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `subject` varchar(32) NOT NULL COMMENT '学习科目',
  `time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '学习时长(分钟)',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学习记录表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `study`
--

INSERT INTO `study` (`id`, `user_id`, `subject`, `time`, `gmt_create`, `gmt_modified`) VALUES
(1, 1, '前端', 2, '2023-10-19 14:37:40', '2023-10-19 14:37:40'),
(2, 1, 'SQL', 4, '2023-10-19 22:49:35', '2023-10-19 22:49:35'),
(4, 1, 'SQL', 2, '2023-10-21 14:31:25', '2023-10-21 14:31:25'),
(5, 1, '算法', 5, '2023-10-21 15:21:49', '2023-10-21 15:21:49'),
(7, 1, 'Java', 1, '2023-10-27 17:10:19', '2023-10-27 17:10:19'),
(8, 1, 'SQL', 1, '2023-10-28 15:54:15', '2023-10-28 15:54:15'),
(9, 3, '算法', 1, '2023-11-01 16:18:59', '2023-11-01 16:18:59'),
(10, 1, 'SQL', 8, '2023-11-07 14:02:13', '2023-11-07 14:02:13'),
(11, 1, '前端', 27, '2023-11-08 18:25:06', '2023-11-08 18:25:06'),
(12, 1, 'Java', 2, '2023-11-10 11:20:06', '2023-11-10 11:20:06'),
(13, 1, 'SQL', 1, '2023-11-10 11:23:25', '2023-11-10 11:23:25'),
(14, 1, '设计', 1, '2023-11-11 09:14:06', '2023-11-11 09:14:06'),
(15, 4, '设计', 1, '2023-11-11 14:34:30', '2023-11-11 14:34:30'),
(16, 4, 'SQL', 1, '2023-11-11 14:35:29', '2023-11-11 14:35:29'),
(17, 1, '前端', 2, '2023-11-12 09:43:30', '2023-11-12 09:43:30'),
(18, 1, '设计', 3, '2023-11-12 09:47:36', '2023-11-12 09:47:36'),
(19, 4, 'SQL', 2, '2023-11-12 10:18:30', '2023-11-12 10:18:30');

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(32) NOT NULL COMMENT '账号',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像路径',
  `nickname` varchar(32) NOT NULL COMMENT '昵称',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `description` varchar(255) DEFAULT NULL COMMENT '简洁',
  `gender` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT '性别:0=男,1=女',
  `email` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `phone` int(10) UNSIGNED DEFAULT NULL COMMENT '手机号',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表' ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `avatar`, `nickname`, `birthday`, `description`, `gender`, `email`, `phone`, `gmt_create`, `gmt_modified`) VALUES
(1, 'MrHee', '123456', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/avatar/1.png', 'MrHee', NULL, '', 0, NULL, NULL, '2023-10-15 23:20:14', '2023-11-01 10:32:54'),
(3, 'xc123456', '123456', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/avatar/3.jpg', '幼稚园先生', NULL, NULL, 0, NULL, NULL, '2023-11-01 15:55:50', '2023-11-01 16:36:52'),
(4, 'lsy123456', 'lsy030930', 'https://learning-assiatant-backup.oss-cn-chengdu.aliyuncs.com/avatar/4.jpg', '考拉的黑眼圈', NULL, NULL, 0, NULL, NULL, '2023-11-01 15:55:55', '2023-11-01 16:36:53');

--
-- 转储表的索引
--

--
-- 表的索引 `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `idx_title` (`title`) USING BTREE;

--
-- 表的索引 `attention`
--
ALTER TABLE `attention`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `uni_fans_attention` (`fans_id`,`attention_id`) USING BTREE;

--
-- 表的索引 `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `collection`
--
ALTER TABLE `collection`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `idx_user` (`user_id`) USING BTREE,
  ADD KEY `idx_received` (`received_id`) USING BTREE,
  ADD KEY `idx_article` (`article_id`) USING BTREE;

--
-- 表的索引 `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `uni_target_user` (`target_id`,`user_id`,`type_id`) USING BTREE,
  ADD KEY `idx_user_id` (`user_id`) USING BTREE;

--
-- 表的索引 `notebook`
--
ALTER TABLE `notebook`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `idx_user` (`user_id`) USING BTREE;

--
-- 表的索引 `notebook_class`
--
ALTER TABLE `notebook_class`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `idx_user` (`user_id`) USING BTREE;

--
-- 表的索引 `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `idx_title` (`title`) USING BTREE;

--
-- 表的索引 `signboard`
--
ALTER TABLE `signboard`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `study`
--
ALTER TABLE `study`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `idx_user` (`user_id`) USING BTREE;

--
-- 表的索引 `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `idx_username` (`username`) USING BTREE;

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `article`
--
ALTER TABLE `article`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- 使用表AUTO_INCREMENT `attention`
--
ALTER TABLE `attention`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `category`
--
ALTER TABLE `category`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用表AUTO_INCREMENT `collection`
--
ALTER TABLE `collection`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `comment`
--
ALTER TABLE `comment`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `history`
--
ALTER TABLE `history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=343;

--
-- 使用表AUTO_INCREMENT `notebook`
--
ALTER TABLE `notebook`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- 使用表AUTO_INCREMENT `notebook_class`
--
ALTER TABLE `notebook_class`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用表AUTO_INCREMENT `resources`
--
ALTER TABLE `resources`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `signboard`
--
ALTER TABLE `signboard`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- 使用表AUTO_INCREMENT `study`
--
ALTER TABLE `study`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
