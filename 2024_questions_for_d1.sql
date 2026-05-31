-- 2024年11月网络规划设计师（综合知识）真题导入D1
-- 数据库: networkcert-daily

-- 先清空可能存在的旧数据（如果需要）
-- DELETE FROM questions WHERE category LIKE '%2024%';

-- 第1题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '下列对IEEE 802.11的MAC层的特点描述，正确的是', '["① 在监听信道时，若信道忙则坚持监听直到信道空闲并执行退避算法", "② MAC层提供了2种访问控制机制，CSMA/CA竞争访问和分布式协调功能", "③ MAC管理子层实现登记过程、ESS漫游、安全管理和电源管理功能", "④ 802.11的3种帧间隔中，DIFS最长，优先级最低"]', 'C', 'IEEE 802.11 MAC层特点分析', 2, '2024年综合知识', '802.11,MAC层,无线网络', 2024);

-- 第2题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '假设某令牌环长度为50km，数据传输速率为16Mbps，环路上有100个站，则环比特长__bits', '["400", "4000", "500", "5000"]', 'B', '传播时延=环路长度/光速=50000m/3×10⁸m/s=1.67×10⁻⁴s，环比特长=16×10⁶×1.67×10⁻⁴=4000bits', 2, '2024年综合知识', '令牌环网络', 2024);

-- 第3题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '制作、复制、发布、传播违法信息，由__依法给予停止传输、采取技术措施', '["国家互联网信息部门", "公安机关"]', 'A', '', 1, '2024年综合知识', '网络法规', 2024);

-- 第4题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '给定一个长度为n的整数数组AI[1..n]，计算数组的最大连续子数组和。以下描述正确的是', '["① 在构建状态转移方程时，每个状态dp[i]需要通过遍历之前的所有元素来计算，这使得算法的时间复杂度为O(n²)", "② 在构建状态转移方程时，可以只考虑当前元素A[i]和前一个状态dp[i-1]", "③ 只需要从左到右遍历数组一次即可得出最优解，无需额外的存储空间来保存中间结果", "④ 如果数组中所有的元素都为负数，那么算法将无法正确计算出最大子数组和"]', 'B', '动态规划求最大连续子数组和，dp[i]=max(dp[i-1]+A[i], A[i])', 3, '2024年综合知识', '动态规划,算法', 2024);

-- 第5题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', 'BGP题目。路由黑洞解决下一跳不可达', '["R2的BGP视图下配置peer 34.1.1.4 next-hop-local", "R2的BGP视图下配置peer 12.1.1.1 next-hop-local"]', 'A', '修改下一跳', 2, '2024年综合知识', 'BGP,路由黑洞', 2024);

-- 第6题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '在FIDO UAF的无口令认证模式中，用户只需通过在移动终端上输入生物特征就可完整认证，其私钥存储在', '["用户设备", "依赖方", "认证方", "注册机构"]', 'A', '私钥存储在用户设备上以确保安全性和隐私', 2, '2024年综合知识', 'FIDO,身份认证', 2024);

-- 第7题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '通信双方采用CRC进行检错，假如生成多项式G(X)=X³+X²+1，接收方收到的码字为101101001，则以下叙述错误的是', '["生成多项式各项系数构成的bit串为1101", "收发双方应使用相同的生成多项式", "接收到的码字最后3位，即001为冗余位", "接收方认为收到的信息没有出现错误"]', 'D', 'CRC检错分析', 2, '2024年综合知识', 'CRC,数据通信', 2024);

-- 第8题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '当用户使用浏览器向服务器提交请求时，使用GET或者POST方法能够提交不超过__的请求', '["1024Kb", "1518Kb", "1046Kb", "1500Kb"]', 'A', '', 1, '2024年综合知识', 'HTTP协议', 2024);

-- 第9题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '结果偏差增大的情形是', '["增加蒙特卡洛模拟的样本数量，但每个样本的权重计算存在系统性误差", "通过自适应采样方法，增加高维积分区域中对重要区域的采样密度"]', 'A', '相当于输入就是错的，那么输出肯定问题很大', 2, '2024年综合知识', '蒙特卡洛模拟', 2024);

-- 第10题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '5G接入网架构相对于4G引入的逻辑网元有', '["①统一数据管理", "②中央单元", "③鉴权服务器", "④UDS"]', 'C', '5G接入网架构相对于4G引入的逻辑网元包括中央单元(CU)和分布单元(DU)', 2, '2024年综合知识', '5G网络', 2024);

-- 第11题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '6G网络中的空天地一体化', '["地面基站、高空平台和卫星网络的深度集成", "基站"]', 'A', '', 1, '2024年综合知识', '6G网络', 2024);

-- 第12题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '路由器收到一个目标地址为FE80::3BD1:92CC:D52E的IPv6数据包，路由器将对其做__处理', '["重新封装后转发", "丢弃"]', 'B', 'FE80::/10是本地链路地址范围，不能通过路由器转发，会直接丢弃', 2, '2024年综合知识', 'IPv6', 2024);

-- 第13题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('multi', 'Software-defined networking (SDN) is an approach to __ that uses abstraction to enable dynamic and programmatically efficient network configuration... (71-75)', '["(71) A.data storage B.network achievement C.network management D.system operations", "(72) A.data caching B.hardware abstraction C.network intelligence D.protocol conversion", "(73) A.application stack B.traffic plane C.data plane D.control plane", "(74) A.firewalls B.routers C.controllers D.switches", "(75) A.unavailability B.redundancy C.scalability D.instability"]', 'C,C,C,C,C', 'SDN是一种网络管理方法，通过抽象化技术，使得网络配置更加动态且程序化高效', 3, '2024年综合知识', 'SDN,网络管理', 2024);

-- 第14题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '下图的网络架构属于', '["环形广域网", "半冗余广域网", "层次子域广域网", "对等子域广域网"]', 'A', '广域网只看路由器连接，是环形', 2, '2024年综合知识', '网络架构', 2024);

-- 第15题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', 'RAID5和RAID6的比较说法中正确的是', '["① 当磁盘组中有一块磁盘故障造成数据丢失时，RAID5使用P校验位恢复，而RAID6使用P和Q校验位恢复数据", "② RAID6的磁盘利用率比RAID5高", "③ RAID5和RAID6写入数据时都存在写惩罚，不过RAID6写入效率更低", "④ RAID5比RAID6数据安全性高"]', 'B', '可靠性提升，牺牲的是空间利用率和写入效率(RAID5惩罚因子是4，RAID6惩罚因子是6)', 2, '2024年综合知识', 'RAID,存储', 2024);

-- 第16题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '某公司计划使用1个C类IP地址为其4个部门分配IP地址，其中部门A大约需要120个IP地址，部门B大约需要50个IP地址，部门C和部门D各需要25个IP地址，地址分配完成后，4个部门A~D的掩码长度分别是', '["25,25,26,26", "25,26,27,28", "25,26,27,27", "26,26,27,28"]', 'C', '', 2, '2024年综合知识', 'IP地址规划', 2024);

-- 第17题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', 'NETCONF协议采用__编码格式', '["XML", "JSON"]', 'A', '', 1, '2024年综合知识', 'NETCONF,网络管理', 2024);

-- 第18题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '已知以太网最大帧长为1518B，IP和TCP最小报头和为40B，则可以传输的TCP数据最大__B', '["1460B", "1480", "1478", "1500"]', 'A', '1518-18(以太开销)-40(IP+TCP报头)=1460B', 1, '2024年综合知识', '以太网,TCP', 2024);

-- 第19题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '在光网络中，为了实现对光信号的灵活处理和动态路由，可能采用__来替代传统的固定波长分配和静态光路交换', '["全光再生器，用于放大和整形光信号", "可重构光分插复用器(ROADM)", "软件定义光网络(SDON)，结合可编程光处理器", "光交叉连接(OXC)设备，但保持其固定配置"]', 'C', '', 2, '2024年综合知识', '光网络,SDON', 2024);

-- 第20题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '下列关于网络性能技术指标的说法中错误的是', '["① 安全性目标是网络安全性问题不应干扰开展业务的能力", "② 网络时延是从网络一端发送一个比特到网络的另一端接收到这个比特所经历的时间，即传播时延等于网络时延", "③ 信道利用率是指一段时间内信道为占用状态的时间与总时间的比值，当信道利用率增大时，该信道引起的时延也会随之增加", "④ 响应时间是指从服务请求发出到接收到响应所花费的时间"]', 'B', '网络时延肯定还包括发送时延', 2, '2024年综合知识', '网络性能', 2024);

-- 第21题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '下列关于利用图论算法建模网络行为的描述，正确的是', '["① 链路状态路由协议建模为最短路径问题，采用Dijkstra算法求解", "② 距离向量路由协议建模为最短路径问题，采用Bellman-Ford算法", "③ P2P网络进行洪泛询问时，为了消除广播风暴，采用生成树算法建模广播转发路径", "④ 建立光纤骨干网络联通每个村镇的问题可以建模为最短路径问题", "⑤ 交换机互联形成回路时，采用生成树算法避免广播风暴"]', 'D', '建立光纤骨干网络联通每个村镇的问题其实是最小生成树问题，而不是最短路径问题', 3, '2024年综合知识', '图论,路由算法', 2024);

-- 第22题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '测试电缆设备物理故障的具体位置', '["时域反射计/光时域反射计", "欧姆表"]', 'A', '', 1, '2024年综合知识', '网络测试', 2024);

-- 第23题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '服务器虚拟化错误的', '["服务器虚拟化是云计算的核心技术", "服务器虚拟化可以把多台物理服务器虚拟为一台VM主机，实现服务器资源整合"]', 'B', '', 2, '2024年综合知识', '虚拟化', 2024);

-- 第24题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '在编译器的优化阶段，引发程序错误的是', '["常量传播", "死代码清除"]', 'A', '', 3, '2024年综合知识', '编译原理', 2024);

-- 第25题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '最大信道利用率是', '["0.40%", "1.96%"]', 'B', '', 3, '2024年综合知识', '信道利用率', 2024);

-- 第26题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', 'OSPF故障原因可能是', '["Hello报文发送间隔时间不一致", "接口的IP地址掩码不一致"]', 'B', '', 2, '2024年综合知识', 'OSPF', 2024);

-- 第27题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '下列关于虚电路网络的叙述中，错误的是', '["虚电路建立后可以确保数据分组按序交付", "路由选择在建立虚电路时进行", "虚电路网络像电路交换一样为每个连接分配固定的带宽", "数据分组转发的依据是虚电路标识号(VCID)"]', 'C', '虚电路网络不像电路交换那样为每个连接分配固定的带宽', 2, '2024年综合知识', '虚电路', 2024);

-- 第28题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', 'N个用户共享一个1Gb/s的链路，假设每个用户需要100Mb/s的带宽，如果采用电路交换方式，该系统仅支持10个用户。若采用分组交换，假设有35个用户，用户活跃的平均概率均为10%，则同时有超过10个用户活跃的概率约为', '["0.2857%", "0%", "0.0004%", "0.010%"]', 'C', '', 3, '2024年综合知识', '分组交换', 2024);

-- 第29题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '并发访问机制是', '["信号量", "文件系统"]', 'A', '', 2, '2024年综合知识', '并发', 2024);

-- 第30题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', 'CSMA/CD选不正确', '["网桥根据MAC帧的目的地址转发时不执行CSMA/CD", "CSMA/CD的冲突检测方法对最短帧长度有限定"]', 'A', '网桥工作在数据链路层，转发时在接口执行CSMA/CD协议', 2, '2024年综合知识', 'CSMA/CD', 2024);

-- 第31题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '按网络五阶段周期划分，在网络需求分析阶段的工作包括', '["①网络性能分析 ②网络流量分析 ③建网成本估算 ④通信规范设计"]', 'B', '', 2, '2024年综合知识', '网络规划', 2024);

-- 第32题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '端口扫描是攻击者收集目标主机信息的一种常用方式，其中FIN扫描是向目标主机发送发送FIN=1的TCP报文，目标主机__，表示该目标主机是活动的', '["回应FIN=0，ACK=1", "回应FIN=1，ACK=1", "丢弃不作任何回复", "丢弃并回复RST"]', 'C', 'FIN扫描若目标端口是关闭状态会响应RST，若开放则不响应', 2, '2024年综合知识', '网络安全,端口扫描', 2024);

-- 第33题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', 'BGP题目。路由黑洞问ping不通的原因', '["AS 200存在路由黑洞", "R2没有到172.16.10.1的路由"]', 'A', '路由黑洞', 2, '2024年综合知识', 'BGP,路由黑洞', 2024);

-- 第34题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '不是QoS模型的是', '["Network Manager Service网络管理服务模型", "区分服务"]', 'A', '', 1, '2024年综合知识', 'QoS', 2024);

-- 第35题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', 'BGP题目。路由黑洞', '["R2收到的是有效但不是最优的路由条目，只会向BGP邻居传递", "R4收到的不是有效且最优的路由条目，不会向BGP邻居传递"]', 'B', '下一跳不可达', 2, '2024年综合知识', 'BGP', 2024);

-- 第36题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '公司对原有的系统安全维护员日常管理操作规范进行了修订，并对相关人员开展了培训。上述内容中涉及到安全管理的__两部分内容', '["安全管理制度和人员安全管理", "安全管理制度和系统运维管理", "安全管理制度和系统建设管理", "人员安全管理和系统建设管理"]', 'A', '安全管理制度是对整个系统安全的规范和要求；人员安全管理是对从事安全维护工作的人员的管理和培训', 2, '2024年综合知识', '安全管理', 2024);

-- 第37题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '假设有一个无向连通图G=(V,E)，每条边都有大于零的权重，则可能使得Kruskal算法生成的最小生成树结构不同的情况是', '["图G是一个简单连通图，所有边的权重互不相同", "图G是一个完全图，所有边的权重互不相同", "图G是一个稀疏图，存在权重相同的边", "图G是一个树，存在权重相同的边"]', 'C', '', 3, '2024年综合知识', '最小生成树,Kruskal', 2024);

-- 第38题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('multi', '假定某双绞线的衰减是0.7dB/km（在1kHz时），若容许有20dB的衰减，使用这种双绞线的链路的工作距离最长为__km。如果要使这种双绞线的工作距离增大到100公里，则应当使衰减降低到__dB/km', '["57.2, 0.1", "16.8, 0.2", "28.6, 0.2", "14.0, 0.4"]', 'C,B', '距离=20dB/(0.7dB/km)=28.6km；100公里有20dB衰减，衰减比为0.2dB/km', 2, '2024年综合知识', '网络传输,衰减', 2024);

-- 第39题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '在一个数据中心网络中，负载均衡器从6台服务器中选出4台分别执行Web、存储、DNS、路由四项不同的任务，若其中甲、乙两台服务器不支持Web任务，则任务选派方案共有__种', '["280", "96", "240", "180"]', 'C', '步骤1: 确定Web任务的服务器选择，由于甲、乙不支持Web任务，因此Web任务只能由剩下的4台服务器中选1台，有4种选择。步骤2: 为其余三个任务选择服务器，从5台服务器中选择3台进行排列P(5,3)=60。步骤3: 计算总方案数 4×60=240', 3, '2024年综合知识', '排列组合', 2024);

-- 第40题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '某公司在其数据中心使用虚拟化平台，为实现虚拟网络隔离使用VXLAN技术，其最常用的配置方法是', '["① 通过虚拟化软件配置", "② 通过SDN控制器配置", "③ 通过SNMP协议配置", "④ 自动配置"]', 'A', '', 2, '2024年综合知识', 'VXLAN,虚拟化', 2024);

-- 第41题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '计划阶段，使用__来识别项目风险', '["ARDEA", "里程碑图", "风险矩阵"]', 'C', '', 2, '2024年综合知识', '项目管理', 2024);

-- 第42题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '(GB/T43331-2023) 属于', '["强制性国家标准", "推荐性国家标准"]', 'B', '', 1, '2024年综合知识', '标准', 2024);

-- 第43题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '假设操作系统页面为4KB，系统采用二级页表结构管理虚拟地址空间，最有可能导致内存访问的时间开销显著增加的是', '["① 一级页表被频繁访问，因此操作系统将其常驻在高速缓存中以减少访问延迟", "② 页表条目包含的有效位被置为无效，并且导致了一次缺页异常", "③ 虚拟地址的前10位用于一级页表的索引，接下来的10位用于二级页表的索引，剩余的12位用于页内偏移", "④ 在访问某个虚拟地址时，发现对应的二级页表不存在，操作系统需要创建新的二级页表"]', 'D', '缺页异常会导致大幅增加内存访问时间开销', 3, '2024年综合知识', '操作系统,页表', 2024);

-- 第44题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '根据以上信息，该PC机发生该故障的原因可能是', '["受到ARP攻击", "本机路由表错误"]', 'A', '从网络抓包可以看出存在ARP攻击痕迹', 2, '2024年综合知识', 'ARP攻击,网络安全', 2024);

-- 第45题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '虚拟化NFV常见的部署环境不包括', '["FAR", "RAN", "VIM", "BDE"]', 'A', '', 2, '2024年综合知识', 'NFV', 2024);

-- 第46题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '使用AdHoc模式组网，可采用的路由协议不包括', '["基于位置路由协议", "分层路由协议", "域间路由协议", "平面路由协议"]', 'C', '域间路由协议通常用于结构化的网络环境，不适合AdHoc网络', 2, '2024年综合知识', 'AdHoc网络', 2024);

-- 第47题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '假定某双绞线的衰减是0.7dB/km（在1kHz时），若容许有20dB的衰减，使用这种双绞线的链路的工作距离最长为__km。如果要使这种双绞线的工作距离增大到100公里，则应当使衰减降低到__dB/km【作答此空】', '["0.1", "0.2", "0.6", "0.4"]', 'B', '距离=20dB/(0.7dB/km)=28.6km；100公里有20dB衰减，衰减比为0.2dB/km', 2, '2024年综合知识', '网络传输', 2024);

-- 第48题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '安全联盟(Security Association，简称SA)是IPSec VPN技术实现的基础，它由一个三元组唯一标识，包括:安全参数索引(SPI)、__和安全协议(AH或ESP)标识符', '["加密算法", "数字签名", "IP目的地址", "安全密钥"]', 'C', '记忆一下', 2, '2024年综合知识', 'IPSec,VPN', 2024);

-- 第49题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '运行OSPF协议的路由器通过Hello协商建立邻居关系，在NBMA网络中，要成功建立邻居关系，在下列的项目中，需要保持一致的是', '["Version, Router ID, Area ID, Hello/Dead Time, Authentication Mode, Option字段中的N/E位", "Password, Netmask, Hello/Dead Time, Authentication Mode", "以上都不对"]', 'A', '', 2, '2024年综合知识', 'OSPF', 2024);

-- 第50题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', 'Trunk接口收到不带标记的标准802.3帧，处理是', '["向缺省VLAN转发", "向VLAN 1转发"]', 'A', '', 2, '2024年综合知识', 'VLAN,Trunk', 2024);

-- 第51题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '下列关于多协议标签交换MPLS的描述，不正确的是', '["MPLS首部封装在IP首部和帧首部中间", "分组经过MPLS VPN时的每一跳都要分析IP报文头"]', 'B', 'MPLS首部封装在IP首部前面，分组经过MPLS VPN时每一跳不需要分析IP报文头', 3, '2024年综合知识', 'MPLS', 2024);

-- 第52题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '以下关于IPsec协议的说法中，不正确的是', '["IPSec只支持IPv4", "IPSec中负责密钥交换的是IKE"]', 'A', '', 2, '2024年综合知识', 'IPSec', 2024);

-- 第53题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', 'BGP题目。路由黑洞问ping不通的原因', '["在R4配置到172.16.10.1的静态路由", "配置MPLS的LSP隧道"]', 'B', '路由黑洞解决几种方案', 2, '2024年综合知识', 'BGP,路由黑洞,MPLS', 2024);

-- 第54题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '流通强度大于1时，分组的排队延迟将趋近于', '["∞", "0", "∞", "1"]', 'C', '', 3, '2024年综合知识', '排队论', 2024);

-- 第55题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '下列关于BGP协议描述中正确的是', '["BGP协议之间的报文通过IP协议进行传输", "BGP协议以15秒为周期发送Keep-alive报文来维持", "BGP分为IBGP和EBGP两种，IBGP运行在AS间", "BGP路由器的邻居关系需要工作人员手工建立"]', 'D', '', 2, '2024年综合知识', 'BGP', 2024);

-- 第56题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '根据政策约束因素确定是否要求配置堡垒主机、蜜罐等系统，__的要求', '["设计优化", "需求分析"]', 'B', '', 2, '2024年综合知识', '网络安全', 2024);

-- 第57题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '网络规划项目范围管理中，范围蔓延通常是由于__引起的', '["项目需求不明确", "供应商问题", "项目团队技能不足", "项目风险管理不当"]', 'A', '', 2, '2024年综合知识', '项目管理', 2024);

-- 第58题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '在国密标识密码SM9中，用户的私钥由__产生', '["用户自己", "PKI", "KGC", "IBC"]', 'C', '', 2, '2024年综合知识', 'SM9,国密算法', 2024);

-- 第59题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '时间戳用来防止__攻击', '["病毒", "DDOS", "重放", "SQL注入"]', 'C', '', 1, '2024年综合知识', '网络安全', 2024);

-- 第60题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '四个无线站点进行码分多址CDMA通信。他们的码片序列分别为s1(-1-1-1+1+1-1+1+1)、s2(-1-1+1-1+1+1+1-1)，接收到码片序列为(-1+1-3+1-1-3+1+1)，则没有发送数据的终端是', '["S4", "S3", "S1", "S2"]', 'B', 's1的正交结果:1，s2的正交结果:-1，s3正交结果:0，s4的正交结果:1。正交结果是1表示收到数据是1，正交结果是-1表示收到数据0，正交结果是0表示没有发送数据', 3, '2024年综合知识', 'CDMA,码分多址', 2024);

-- 第61题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '要求扩展性，部署可以采用__架构', '["TOR", "MOR", "EOR", "CSS"]', 'A', '', 2, '2024年综合知识', '数据中心', 2024);

-- 第62题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '最易死锁的是', '["允许进程根据当前资源分配情况发出资源请求，并且系统始终优先满足优先级高进程对资源的请求", "允许进程根据当前资源分配情况发出资源请求，并且协调按照进程的对资源请求顺序满足请求"]', 'A', '系统优先满足优先级高的进程对资源的请求，可能导致优先级低的进程始终得不到资源，形成"饥饿"现象。如果这些低优先级进程也持有部分资源，但还在等待其他资源时，就可能导致死锁', 3, '2024年综合知识', '死锁,操作系统', 2024);

-- 第63题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '某信道最高的码元速率为10000码元/秒，采用振幅调制将码元的振幅划分为64个不同等级，则该信道可以获得的最大数据速率为', '["60000", "640000", "10000", "64000"]', 'A', 'R=Blog₂N=10000log₂64=60000', 2, '2024年综合知识', '奈奎斯特,带宽', 2024);

-- 第64题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '所需的最小带宽为__Hz', '["40000", "43000", "39600", "44000"]', 'D', '', 3, '2024年综合知识', '带宽', 2024);

-- 第65题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '在TCP三次握手状态1、状态2和状态3分别是', '["SYN_SENT, SYN_RCVD, ESTABLISHED", "SYN_SENT, SYN_RCVD, SYN_WAIT"]', 'A', '', 2, '2024年综合知识', 'TCP三次握手', 2024);

-- 第69题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '收敛比是', '["4:1", "1.6:1"]', 'B', '', 2, '2024年综合知识', '网络收敛', 2024);

-- 第70题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '可能违反数据库原子性的操作是', '["操作引发了死锁，数据库管理系统选择将其中一个事务回滚", "崩溃前未能将日志持久化到磁盘并丢失"]', 'B', '', 3, '2024年综合知识', '数据库原子性', 2024);

-- 第71题
INSERT INTO questions (type, content, options, answer, explanation, difficulty, category, tags, year) VALUES
('single', '基于流水线设计的RISC处理器中，假设存在以下五个流水线阶段:取指、指令译码、执行指令、访问内存、写回，最有可能导致严重的流水线阻塞，从而显著降低处理器性能的情况是', '["① 在访存阶段，处理器遇到了一条存储指令，但数据缓存(Cache)命中了所需的数据", "② 在执行过程中，遇到了一条条件分支指令，并且分支预测发生了错误", "③ 在执行过程中，指令间存在数据依赖性，处理器使用了转发技术来解决该依赖性", "④ 在指令译码阶段，处理器发现了一条与之前指令完全无关的指令"]', 'D', '当分支预测错误时，处理器需要清除流水线中错误分支路径上的指令，并重新取指。这会导致多周期的流水线停顿，从而严重影响处理器性能', 3, '2024年综合知识', '流水线,RISC', 2024);