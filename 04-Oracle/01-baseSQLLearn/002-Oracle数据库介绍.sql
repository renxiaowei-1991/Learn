1、数据库与实例的关系
数据库(Database)：物理操作系统文件或磁盘的集合。(数据库是磁盘上存储的数据文件集合)
实例(instance)：一组Oracle后台进程/线程以及一个共享内存区，这些内存由同一个计算机上运行的统一线程/进和所共享。(实例就是一组后进程和共享内存)
实例与数据库之间的关系是：数据库可以由多个实例装载和打开，而实例可以在任何时间点装载和打开一个数据库。

2、Oralce数据库所包含的文件类型
与实例相关的文件：参数文件(parameter file)、跟踪文件(trace file)、警告文件(alert file)
构成数据库的文件：数据文件(data file)、临时文件(temp file)、控制文件(control file)、重做日志文件(redo log file)、密码文件(password file)
Oracle 10g新增文件：修改跟踪文件(change tracking file)、闪回日志文件(flashback log file)
其他类型文件：转储文件(DMP file)、数据泵文件(Data Pumn file)、平面文件(flat file)

3、Oracle数据库构成(表空间(tablespace)、段(segment)、区段(extent)、块(block)的关系)
表空间(tablespace)：是Oracle中的一个逻辑存储容器，位于存储层次体系的顶层，包含           一个或多个数据文件
段(segment)：占用存储空间的数据为对象，如表、索引、回滚段等；段由一个或多个区段组成
区段(extent)：是文件中一个逻辑上连续分配的空间；区段由块组成
块(block)：是Oracle中最小的空间分配单位；数据行、索引条目或临时排序结果就存储在块中；Oracle中常见的块大小：2K、4K、8K、16K(最大不能超过32K)
它们之间的关系：数据库由一个或多个表空间组成，表空间由一个或多个数据文件组成，表空间包含段，段由一个或多个区段组成，区段则由连续的块组成

4、名称解释
决策支持系统(DSS)：Decision Support System
联机事务处理(OLTP)：On-line Transaction Processing
联机分析处理(OLAP)：On-Line Analytical Processing也称为在线分析处理。
ETL(Extraction-Transformation-Loading)：抽取(Extraction)、转换(Transformation)、载入(Loading)  ETL负责将分布的、异构数据源中的数据如关系数据、平面数据文件等抽取到临时中间层后进行清洗、转换、集成，最后加载到数据仓库或数据集市中，成为联机分析处理、数据挖掘的基础。 ETL是数据仓库中的非常重要的一环。
关系数据库管理系统(RDBMS)：Relational Database Management System
表的三种联接方式:nested loop(嵌套循环连接)、sort merge join(排序合并连接)、hash join(哈希连接)
数据查询语言(Select):用于检索数据库数据
数据定义语言(DDL)：Data Definition Language(如 create table、alter table、truncate table):用于建立、修改和删除数据为对象(采用先提交(commit)，再执行DDL，再COMMIT，所有如果有必须回滚的事务，DDL不会回滚而会直接提交(commit))
数据操纵语言(DML): Data Manipulation Language(包含:insert、update、delete):用于改变数据库数据
数据控制语言(DCL): Data Control Language(包含:grant、revoke):用于执行权限授予和收回操作(同数据操纵语言DML会自动提交事务)
事务控制语言(TCL):Transactional Control Language(Commit、Rollback、Savepoint)：用于维护数据的一致性
Recursive Calls：Number of recursive calls generated at both the user and system level.（用户与系统造成的递归调用数）
DB Block Gets：请求的数据块在buffer能满足的个数(Number of times a CURRENT block was requested.)
Consistent(一致性) Gets：数据请求在回滚段Buffer中的总数 (Number of times a consistent read was requested for a block.)
Physical Reads：从磁盘读到Buffer Cache数据块数量(Total number of data blocks read from disk. This number equals the value of "physical reads direct" plus all reads into buffer cache)
Sorts (disk)：Number of sort operations that required at least one disk write. Sorts that require I/O to disk are quite resource intensive. Try increasing the size of the initialization parameter SORT_AREA_SIZE.(排序运算需要的最小磁盘写)
PCTFREE：PCTFREE参数用于指定块中必须保留的最小空闲空间比例.之所以要为块保留一些空闲空间,是因为在对块中存储的数据进行修改时(UPDATE操作),有可能会需要更多的存储空间.这时如果块中存储空间不足,就必须分配新块,此时会产生指针,降低性能.而如果每块在最初填写数据时均不填满,保留一部分可用空间,比如20%,则可以尽量避免上述问题. 当一些块在以后使用时,比如进行update操作时,则可以使用那20%的空间.而如果一些块中的数据后来又没有了或减少了,比如由原来的90%变为70%,因为已符合PCTFREE的规定,那么如果有INSERT操作的话,则该块又可以被使用了,但实际上这个块只有10%的空间可以给INSERT操作使用,所以这种情况应该避免.那就用到了下面的参数(PCTUSED)
PCTUSED：PCTUSED参数用于指定一个百分比,当块中已经使用的存储空间降低到这个百分比之下时,这个块才被标记为可用,否则按上面的即使块中已经有30%的可用空间,块依然不可用. 这是ORACLE为了防止出现太大的数据碎片导至降低数据库性能及防止浪费空间而导至磁盘利用率低的一个提供给专业用户使用的参数！   
    当一个块写到pctused所指定的值时（如：80%），这个块就被标记为已用，不可以再朝里边写数据，以为日后修改此块内的某条记录（主要是增加数据量）提供条件
    当一个块因为修改及删除记录而使其占用率降低到pctfree所指定的值时（如：20%）， 在数据字典里这个块被标记为可用，新增加的记录就可以朝这个块里写数据
    这个参数非常专业，一定要你非常熟悉磁盘调整及了解自己数据库的应用特点才可以调整，而且调整此参数一定要很有经验，建议不是很确定不要随意调整，因为会大大降低数据库效率的
INITRANS：参数确定为事务处理项预分配多少数据块头部的空间。当您预计有许多并发事务处理要涉及某个块时，可为相关的事务处理项预分配更多的空间，以避免动态分配该空间的开销。
MAXTRANS：参数限制并行使用某个数据块的事务处理的数量。当您预计有许多事务处理将并行访问某个小表时，则当创建表时，应设置该表的事务处理项预分配更多的块空间，较高的MAXTRANS 参数值允许许多事务处理并行访问该表INITRANS和MAXTRANS 参数的设置可能相应低一些（如分别为2和5）
