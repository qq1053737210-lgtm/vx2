--[[ ============================================================
     一键：加载 Venyx Hub + 自动汉化
     用法：执行本脚本，什么都不用管
     有卡密就把下面 KEY 填上；没有就留空
============================================================ ]]--

local CFG = {
    HUB_URL   = "https://raw.githubusercontent.com/tienkhanh1/Venyx/main/VenyxHub",
    KEY       = "",      -- 卡密填这里，例如 "ABCD-1234"；没有就留空
    hookFirst = true,    -- 先装钩子再加载 Hub（文字一出现就是中文，不闪英文）
                         -- 若 Hub 因此加载失败，把它改成 false
    poll      = 2,       -- 每 2 秒补扫一次（翻新出现的文字）
}

-- ========================= 词库 =========================
local DICT = {
["SYSTEM  /  CONFIG"]="系统 / 配置",["SYSTEM  /  CONFIG  /  PROFILES"]="系统 / 配置 / 档位",
["SYSTEM  /  INTERFACE"]="系统 / 界面",["SYSTEM  /  INTERFACE  /  DEFAULTS"]="系统 / 界面 / 默认设置",
["SYSTEM  /  INTERFACE  /  GAME HUD"]="系统 / 界面 / 游戏 HUD",
["SYSTEM  /  INTERFACE  /  PINS AND KEYBINDS"]="系统 / 界面 / 固定与快捷键",
["SYSTEM  /  INTERFACE  /  QUICK BARS"]="系统 / 界面 / 快捷栏",
["SYSTEM  /  OPTIMIZER  /  BASES"]="系统 / 优化 / 基地",
["SYSTEM  /  OPTIMIZER  /  FRAME RATE"]="系统 / 优化 / 帧率",
["SYSTEM  /  OPTIMIZER  /  GRAPHICS"]="系统 / 优化 / 画质",
["SYSTEM  /  SERVER"]="系统 / 服务器",["SYSTEM  /  SERVER  /  JOIN AND STAY"]="系统 / 服务器 / 加入并停留",
["SYSTEM  /  WEBHOOK  /  DISCORD WEBHOOK"]="系统 / 推送 / Discord 推送",
["SYSTEM  /  WEBHOOK  /  WHAT TO POST"]="系统 / 推送 / 推送内容",
["FARM  /  FUSE  /  FUSE FILTER"]="刷取 / 融合 / 融合筛选",
["FARM  /  FUSE  /  FUSE MACHINE"]="刷取 / 融合 / 融合机",
["FARM  /  MUTATE  /  AUTO MUTATE"]="刷取 / 变异 / 自动变异",
["FARM  /  MUTATE  /  MUTATE FILTER"]="刷取 / 变异 / 变异筛选",
["FARM  /  PEN  /  AUTO HATCH"]="刷取 / 围栏 / 自动孵化",
["FARM  /  PEN  /  AUTO PLACE"]="刷取 / 围栏 / 自动放置",
["FARM  /  PEN  /  KEEP EGGS"]="刷取 / 围栏 / 保留蛋",
["FARM  /  PRIORITY  /  PRIORITY ROTATION"]="刷取 / 优先 / 优先轮换",
["FARM  /  SELL  /  EGGS"]="刷取 / 出售 / 蛋",["FARM  /  SELL  /  FAVORITE"]="刷取 / 出售 / 收藏",
["FARM  /  SELL  /  PETS"]="刷取 / 出售 / 宠物",["FARM  /  TREADMILL"]="刷取 / 跑步机",
["FARM  /  TREADMILL  /  PROGRESS"]="刷取 / 跑步机 / 进度",
["PLAYER  /  COMBAT  /  AUTO HIT"]="玩家 / 战斗 / 自动打击",
["PLAYER  /  COMBAT  /  HIT AURA"]="玩家 / 战斗 / 打击光环",
["PLAYER  /  COMBAT  /  WEAPONS"]="玩家 / 战斗 / 武器",
["PLAYER  /  ESP  /  FIELD EGGS"]="玩家 / 透视 / 场地蛋",
["PLAYER  /  ESP  /  OTHERS"]="玩家 / 透视 / 其他玩家",
["PLAYER  /  MOVE  /  MOVEMENT"]="玩家 / 移动 / 移动",
["PLAYER  /  MOVE  /  PROTECTION"]="玩家 / 移动 / 保护",
["STEAL  /  AUTO STEAL"]="偷取 / 自动偷取",
["STEAL  /  AUTO STEAL  /  AUTO HOP SERVER"]="偷取 / 自动偷取 / 自动换服",
["STEAL  /  AUTO STEAL  /  FILTER"]="偷取 / 自动偷取 / 筛选",
["STEAL  /  EGG PREDICTOR  /  EGG SHOWCASE"]="偷取 / 蛋预测 / 蛋展示",
["EVENT  /  AA  /  ADMIN ABUSE"]="活动 / 管理 / 管理员乱搞",
["EVENT  /  AA  /  CAPTURE THE EGG"]="活动 / 管理 / 夺蛋战",
["EVENT  /  AA  /  CURSED ISLAND WARS"]="活动 / 管理 / 诅咒岛屿战争",
["EVENT  /  AA  /  MINIGAME EGGS"]="活动 / 管理 / 小游戏蛋",
["EVENT  /  BUTTERFLY  /  BUTTERFLY BLOOM"]="活动 / 蝴蝶 / 蝴蝶绽放",
["EVENT  /  BUTTERFLY  /  BUTTERFLY MACHINE"]="活动 / 蝴蝶 / 蝴蝶机",
["EVENT  /  BUTTERFLY  /  WISP COMPANION"]="活动 / 蝴蝶 / 精灵伙伴",
["EVENT  /  HALLOWEEN & STAR  /  GHOST DOG AND FISHING"]="活动 / 万圣节与星辰 / 幽灵狗与钓鱼",
["EVENT  /  HALLOWEEN & STAR  /  HALLOWEEN DIMENSION"]="活动 / 万圣节与星辰 / 万圣节维度",
["EVENT  /  HALLOWEEN & STAR  /  MONSTERS"]="活动 / 万圣节与星辰 / 怪物",
["EVENT  /  HALLOWEEN & STAR  /  PHANTOM EXPRESS"]="活动 / 万圣节与星辰 / 幻影快车",
["EVENT  /  HALLOWEEN & STAR  /  PUMPKIN MOON"]="活动 / 万圣节与星辰 / 南瓜之月",
["EVENT  /  HALLOWEEN & STAR  /  SHOOTING STAR"]="活动 / 万圣节与星辰 / 流星",
["+  Announcement"]="+  公告",["+  Cancel server event"]="+  取消服务器活动",
["+  Clear eggs"]="+  清除蛋",["+  Close creator server"]="+  关闭创作者服务器",
["+  Egg disguise"]="+  蛋伪装",["+  Egg size & spawn luck"]="+  蛋大小与生成幸运",
["+  Follow player"]="+  跟随玩家",["+  Free camera"]="+  自由视角",
["+  Give animal"]="+  给予动物",["+  Give egg"]="+  给予蛋",
["+  Give event items"]="+  给予活动物品",["+  Go to zone"]="+  前往区域",
["+  Guard disguise"]="+  守卫伪装",["+  Guard disguise pose"]="+  守卫伪装姿势",
["+  Guard speed & size"]="+  守卫速度与大小",["+  Hide game UI"]="+  隐藏游戏界面",
["+  Hide nameplates"]="+  隐藏名牌",["+  Invincibility"]="+  无敌",
["+  Invite players"]="+  邀请玩家",["+  Join server"]="+  加入服务器",
["+  Manage whitelist"]="+  管理白名单",["+  Movement speed"]="+  移动速度",
["+  Mutate a pen pet"]="+  变异围栏宠物",["+  Open creator server"]="+  开启创作者服务器",
["+  Open new zones"]="+  解锁新区域",["+  Pause pursuit"]="+  暂停追捕",
["+  Player disguise"]="+  玩家伪装",["+  Saved profiles"]="+  已保存档位",
["+  Send player"]="+  发送玩家",["+  Server boosts"]="+  服务器加成",
["+  Server directory"]="+  服务器目录",["+  Skip egg timer"]="+  跳过蛋计时",
["+  Spawn an egg"]="+  生成一个蛋",["+  Spawn mutated pet"]="+  生成变异宠物",
["+  Spectate player"]="+  观战玩家",["+  Stage a prank"]="+  上演恶作剧",
["+  Start server event"]="+  开始服务器活动",
["Auto Sell"]="自动出售",["Auto hatch"]="自动孵化",["Auto place"]="自动放置",
["Auto steal"]="自动偷取",["Auto mutate"]="自动变异",["Auto hit"]="自动打击",
["Auto fuse"]="自动融合",["Auto fishing"]="自动钓鱼",["Auto save"]="自动保存",
["Auto load"]="自动加载",["Auto load script"]="自动加载脚本",["Auto favorite"]="自动收藏",
["Auto sell eggs"]="自动出售蛋",["Auto sell pets"]="自动出售宠物",
["Auto treadmill"]="自动跑步机",["Auto upgrade treadmill"]="自动升级跑步机",
["Auto claim index rewards"]="自动领取图鉴奖励",["Auto claim offline cash"]="自动领取离线收益",
["Auto craft essence"]="自动制作精华",["Auto buy trails"]="自动购买尾迹",
["Auto capture event egg"]="自动夺取活动蛋",["Auto catch shooting star"]="自动抓流星",
["Auto vacuum Ghouler boss"]="自动清剿食尸鬼首领",
["Admin treadmill"]="管理员跑步机",
["Farm"]="刷取",["Steal"]="偷取",["Fuse"]="融合",["Mutate"]="变异",["Mutations"]="变异",
["Pen"]="围栏",["Treadmill"]="跑步机",["Eggs"]="蛋",["Pets"]="宠物",["Pet"]="宠物",
["Egg"]="蛋",["Shop"]="商店",["Item Name"]="物品名称",["Egg Name"]="蛋名称",
["Pet Name"]="宠物名称",["Animal Name"]="动物名称",["Animal name"]="动物名称",
["Boss Name Here"]="首领名称",["Reward Name"]="奖励名称",["Race Name"]="竞速名称",
["World"]="世界",["Zone"]="区域",["Jungle"]="丛林",["Garden"]="花园",["Ocean"]="海洋",
["Mastery"]="精通",["Equip"]="装备",["Equip Best"]="装备最佳",["Equipped"]="已装备",
["Unequip"]="卸下",["Owned"]="已拥有",["Locked"]="未解锁",["Unlocked!"]="已解锁！",
["Empty"]="空",["Enabled"]="已启用",["Off"]="关",["On"]="开",["OFF"]="关",["ON"]="开",
["Ready"]="就绪",["Ready."]="就绪。",["READY!"]="就绪！",["READY NOW"]="可以就绪了",
["Loading..."]="加载中…",["Completed"]="已完成",["In Progress"]="进行中",
["Not here"]="不在此处",["Sold Out"]="售罄",["Limited"]="限定",["Featured"]="精选",
["New!"]="新！",["Next Reward"]="下个奖励",["NEXT WEEK"]="下周",["NEXT!"]="下一个！",
["PART 1"]="第 1 部分",["Up"]="上",["Down"]="下",["Back"]="返回",["Return"]="返回",
["Exit"]="退出",["Escape"]="逃脱",["Go"]="前往",["Give"]="给予",["Send"]="发送",
["Sent"]="已发送",["Recv"]="接收",["Gift"]="礼物",["Gift Player"]="赠送玩家",
["Drop"]="掉落",["Spawn"]="生成",["Ride"]="骑乘",["Mount"]="坐骑",["Pose"]="姿势",
["Set pose"]="设置姿势",["Stand"]="站立",["Scene"]="场景",["Camera"]="相机",
["Free camera"]="自由视角",["Disguise"]="伪装",["Disguise as player"]="伪装成玩家",
["Display name"]="显示名称",["Preview account"]="预览账号",["Preview card"]="预览卡片",
["Guest list"]="访客列表",["Manage"]="管理",["Manage guests"]="管理访客",
["Add guest"]="添加访客",["Servers"]="服务器列表",["Server event"]="服务器活动",
["Start event"]="开始活动",["Cancel event"]="取消活动",["Open server"]="开启服务器",
["Close server"]="关闭服务器",["Join server"]="加入服务器",["Find a player"]="查找玩家",
["Find"]="查找",["Chosen player"]="已选玩家",["Nearest player"]="最近玩家",
["Follow player"]="跟随玩家",["Invite player"]="邀请玩家",["Invite players"]="邀请玩家",
["Spectate"]="观战",["Switch"]="切换",["Select"]="选择",["Select All"]="全选",
["Select/Swap"]="选择/交换",["SELECTED"]="已选择",["Buttons (Selected)"]="按钮（已选）",
["Buttons"]="按钮",["Button"]="按钮",["Option"]="选项",["Panel"]="面板",
["Panel title"]="面板标题",["Menu Navigation"]="菜单导航",["Tab"]="页签",["Tabs"]="页签",
["Value"]="价值",["Total Value:"]="总价值：",["Best Value!"]="最佳价值！",["BEST VALUE!"]="最佳价值！",
["Weight"]="重量",["Size (0.1–100)"]="大小（0.1–100）",["Egg size (0.1–100)"]="蛋大小（0.1–100）",
["Random size"]="随机大小",["Fixed size"]="固定大小",["Amount (1–25)"]="数量（1–25）",
["Amount (1–1000000)"]="数量（1–1000000）",["Minutes (1–120)"]="分钟（1–120）",
["Spawn luck (1–999)"]="生成幸运（1–999）",["Money"]="金钱",["MONEY"]="金钱",
["Money/s"]="金钱/秒",["Money/s:"]="金钱/秒：",["Samples"]="样本",["Sample Shop"]="样本商店",
["Collection"]="图鉴",["Index"]="图鉴",["Pet Index"]="宠物图鉴",["Kills"]="击杀数",
["Wins"]="胜场",["Current Wins"]="当前胜场",["Current Mastery"]="当前精通",
["Boss Mastery"]="首领精通",["Boss Tokens"]="首领代币",["Rings Collected"]="已收集圆环",
["Trophies"]="奖杯",["Rewards:"]="奖励：",["Stars"]="星星",["Progress 0 / 3"]="进度 0 / 3",
["Stage 1"]="阶段 1",["Stage 2"]="阶段 2",["Stage 3"]="阶段 3",["Stage 4"]="阶段 4",
["Rare from"]="稀有来源",["Rarity ↑"]="稀有度 ↑",["All rarities"]="全部稀有度",
["Only mutations"]="仅变异",["No mutation"]="无变异",["Possible Mutations"]="可能变异",
["Mutation luck"]="变异幸运",["Mutation Consumable"]="变异消耗品",
["Guarantees Mutation!"]="必定变异！",["Calculate mutations"]="计算变异",
["Cards show the value with these mutations added"]="卡片显示加上这些变异后的数值",
["Include equipped pets"]="包含已装备宠物",["Skip eggs with"]="跳过满足此条件的蛋",
["Skip timer"]="跳过计时",["Only during Blood Moon"]="仅血月期间",["Keep away"]="保持距离",
["Hold each"]="每次保持",["Hold height"]="保持高度",["Hold to Cast"]="按住施法",
["Cast luck"]="施法幸运",["Delivery method"]="投放方式",["Delivery speed"]="投放速度",
["Tween"]="补间",["Tween speed"]="补间速度",["Bar size"]="条大小",["UI scale"]="界面缩放",
["Opacity"]="不透明度",["Tone"]="音调",["Background color"]="背景颜色",
["Slow Mode"]="慢速模式",["SWITCH IN"]="切换间隔",["First hop after"]="首次换服间隔",
["Hop to"]="换服到",["Hop when"]="换服条件",["NIGHT IN"]="夜晚剩余",
["GOES AWAY IN"]="消失倒计时",["RESPAWNING IN"]="重生倒计时",["RACE STARTS IN"]="竞速开始倒计时",
["LAP 1/3"]="第 1 圈 / 共 3 圈",["LAP 2/3"]="第 2 圈 / 共 3 圈",["Time Left"]="剩余时间",
["Timer"]="计时器",["Weekly Stock: 5/5"]="每周库存：5/5",["Daily Stock: 3/3"]="每日库存：3/3",
["WEATHER EVENT"]="天气事件",["PITY"]="保底",["BOOST"]="加成",["UPGRADE"]="升级",
["MAX EQUIP"]="最大装备",["DRIFT"]="漂移",["CHARGE"]="充能",["CHARGED"]="已充能",
["Gear"]="装备",["gear"]="装备",["ACTIVE"]="活跃",["Online in game"]="在游戏中在线",
["People"]="人数",["Players"]="玩家",["Least players"]="最少玩家",["Closest"]="最近",
["Are you sure?"]="确定吗？",["Confirm"]="确认",["Accept"]="接受",["Decline"]="拒绝",
["Cancel"]="取消",["Apply"]="应用",["Add"]="添加",["Test"]="测试",["Report"]="举报",
["Check It Out"]="去看看",["Yes!"]="是的！",["YES"]="是",["NO"]="否",
["Ok!"]="好的！",["OK!"]="好的！",["Hey!"]="嘿！",["RUN!"]="快跑！",["RUN!!"]="快跑！！",
["PERFECT!"]="完美！",["OP!"]="超模！",["FIX"]="修复",["Claim"]="领取",["Claim!"]="领取！",
["CLAIM!"]="领取！",["Start"]="开始",["Stop"]="停止",["Reset"]="重置",
["Dismount"]="下坐骑",["TARGETED!"]="被锁定！",["REVENGE..."]="复仇…",
["COMING..."]="敬请期待…",["Event ended"]="活动已结束",["Going Away Soon!"]="即将消失！",
["Limited Time!"]="限时！",["TREE UNLOCKED"]="树木已解锁",
["Unlocked: 59/112"]="已解锁：59/112",["Your best egg shows here"]="最佳蛋会显示在这里",
["Your quests"]="你的任务",["Your Team"]="你的队伍",["Your Wisp is home"]="你的精灵回家了",
["No eggs caught yet"]="还没有捕获蛋",["No eggs to show right now"]="当前没有可显示的蛋",
["No eggs yet"]="还没有蛋",["No comments yet!"]="还没有评论！",
["No item equipped."]="未装备物品。",["No option matches"]="没有匹配的选项",
["No admin boost right now"]="当前没有管理员加成",["No 3 matching pets"]="没有 3 只匹配的宠物",
["Welcome back"]="欢迎回来",["WHAT'S NEW"]="更新内容",["Update Required"]="需要更新",
["Restart Now"]="立即重启",["Unload hub"]="卸载 Hub",["This is a popup"]="这是一个弹窗",
["Ready to copy"]="可复制",["Select an Egg"]="选择蛋",["SELECT AN OPTION"]="选择一个选项",
["Choose..."]="选择…",["Choose an option"]="选择一个选项",["Choose a pet"]="选择宠物",
["Choose an egg"]="选择蛋",["Choose an egg to mutate"]="选择要变异的蛋",
["Pick to delete"]="选择要删除的",["Remove Egg"]="移除蛋",["Placed egg"]="已放置的蛋",
["Place Egg"]="放置蛋",["Place eggs"]="放置蛋",["Place first"]="优先放置",
["Place when"]="放置条件",["Eject odd pets"]="弹出奇数宠物",
["Unfavorite pets not matching"]="取消收藏不匹配的宠物",["View Your Pets"]="查看你的宠物",
["View Other's Pets"]="查看他人的宠物",["Black"]="黑",["White"]="白",["RED"]="红",
["BLUE"]="蓝",["Basic"]="基础",["Normal"]="普通",["Uncommon"]="不常见",["Epic"]="史诗",
["Legacy"]="传承",["Banner"]="横幅",["Now"]="现在",
["Event"]="活动",["event"]="活动",["HALLOWEEN"]="万圣节",["Halloween"]="万圣节",
["HALLOWEEN & STAR"]="万圣节与星辰",["Halloween & Star"]="万圣节与星辰",
["HALLOWEEN DIMENSION"]="万圣节维度",["HALLOWEEN DIMENSION EGG"]="万圣节维度蛋",
["HALLOWEEN EGG"]="万圣节蛋",["Halloween eggs"]="万圣节蛋",
["Halloween rarities"]="万圣节稀有度",["PHANTOM EXPRESS"]="幻影快车",
["Phantom Express"]="幻影快车",["PUMPKIN MOON"]="南瓜之月",["Pumpkin Moon"]="南瓜之月",
["SHOOTING STAR"]="流星",["Shooting Star"]="流星",["BUTTERFLY"]="蝴蝶",
["Butterfly"]="蝴蝶",["BUTTERFLY BLOOM"]="蝴蝶绽放",["Butterfly Bloom"]="蝴蝶绽放",
["BUTTERFLY MACHINE"]="蝴蝶机",["Butterfly machine"]="蝴蝶机",
["Butterfly Net"]="捕蝶网",["Butterfly Trade Up"]="蝴蝶升级交易",
["Catching butterflies"]="抓捕蝴蝶",["Need More Butterflies"]="需要更多蝴蝶",
["WISP COMPANION"]="精灵伙伴",["Wisp quest"]="精灵任务",["Wisp Challenge"]="精灵挑战",
["Grow Your Wisp"]="培养你的精灵",["Baby Wisp"]="精灵宝宝",
["GHOST DOG AND FISHING"]="幽灵狗与钓鱼",["Ghost Dog quest"]="幽灵狗任务",
["Ghost target"]="幽灵目标",["Ghost Fish"]="幽灵鱼",["Ghost Reaper"]="幽灵收割者",
["CURSED ISLAND WARS"]="诅咒岛屿战争",["Island Wars target"]="岛屿战争目标",
["CAPTURE THE EGG"]="夺蛋战",["MINIGAME EGGS"]="小游戏蛋",["ADMIN ABUSE"]="管理员乱搞",
["MONSTERS"]="怪物",["Monsters"]="怪物",["MONSTERS ARE"]="怪物正在",
["MONSTER EGG"]="怪物蛋",["MONSTER OBBY"]="怪物关卡",["MONSTER CHARGE"]="怪物充能",
["MONSTER CHEST REWARDS"]="怪物宝箱奖励",["THE FOG IS COMING!"]="雾要来了！",
["THUNDERSTORM"]="雷暴",["ENCHANTED FOREST"]="附魔森林",["Enchanted Forest"]="附魔森林",
["Enchanted Forest..."]="附魔森林…",["Enchanted Mutation Shrine"]="附魔变异神龛",
["Enchanted Essence"]="附魔精华",["The Rift"]="裂隙",["Shattered Rift"]="破碎裂隙",
["DIVINE FUSION"]="神圣融合",["ETERNAL FUSION"]="永恒融合",
["STOLEN EXPERIMENT VAULT"]="失窃实验金库",["EXPERIMENTS"]="实验",
["Experimental Pets"]="实验宠物",["Experiment Egg"]="实验蛋",
["Dr. Scramble"]="混沌博士",["Dr. Scramble's Lab"]="混沌博士的实验室",
["Drone Parts"]="无人机零件",["Lost Parts"]="缺失零件",
["Dropped by Dr. Scramble's Drones"]="由混沌博士的无人机掉落",
["Soul Extractor"]="灵魂提取器",["Sample Shop"]="样本商店",["Trail Shop"]="尾迹商店",
["Speed Shop"]="速度商店",["Boss Shop"]="首领商店",["MOUNTS..."]="坐骑…",
["PASSES"]="通行证",["QUESTS"]="任务",["TRAILS"]="尾迹",["SAMPLES"]="样本",
["SPEED"]="速度",["The Great Bloom Has Begun!"]="大绽放开始了！",
["Halloween Has Begun!"]="万圣节开始了！",["The Phantom Express has arrived!"]="幻影快车已抵达！",
["The Dragon Lair has opened!"]="龙巢已开启！",["Rescue the Dragon!"]="去救龙！",
["The Hungry Monster Has Arrived!"]="饥饿怪物出现了！",["FEED THE MONSTER"]="喂养怪物",
["A SHOOTING STAR HAS FALLEN!"]="有一颗流星坠落了！",
["A Blood Moon rises in the Corrupted Realm!"]="腐化领域升起了血月！",
["HE'S OVERHEATING!"]="他要过热了！",["Charge the EMP Bar!"]="为 EMP 能量条充能！",
["Charge Your Egg!"]="给你的蛋充能！",["HOLD THE EGG TO EARN TIME"]="抱住蛋来争取时间",
["BRING THE EGG BACK TO SPAWN"]="把蛋带回出生点",["RETURN THE WISP"]="送回精灵",
["RETURN HOME"]="返回基地",["Return to the Beanstalk"]="回到豆茎",
["Water the Beanstalk"]="浇灌豆茎",["Fly to the Top!"]="飞到顶端！",
["FIND A PARASITE"]="找到寄生虫",["CLAIM THE CHEST"]="领取宝箱",
["COLLECT CRYSTALS"]="收集水晶",["DEPOSIT CRYSTALS"]="存入水晶",
["FISH CAUGHT"]="已钓到",["FISHING HISTORY"]="钓鱼记录",["Treadmill Videos"]="跑步机视频",
["TreadmillPro"]="跑步机专业版",["2x Cash Booster"]="双倍现金加成",
["2x Egg Growth"]="双倍蛋成长",["2x Treadmill Booster"]="双倍跑步机加成",
["2x Trophies"]="双倍奖杯",["Friend Boost: +100%"]="好友加成：+100%",
["LION NAME"]="狮子名称",["WHALE NAME"]="鲸鱼名称",
["Select Eggs to Sacrifice!"]="选择要献祭的蛋！",["Select Pets to Fuse!"]="选择要融合的宠物！",
["Select Pets to Sacrifice!"]="选择要献祭的宠物！",
["Would you like to sell your pet?"]="要出售你的宠物吗？",
["What to give"]="给予什么",["Run prank"]="恶作剧",["Wall Builder"]="造墙器",
["Jump Pad"]="跳板",["Landmine"]="地雷",["Launcher"]="发射器",["Racers"]="参赛者",
["Racing"]="竞速",["First place = 1 win!"]="第一名 = 1 胜场！",
["COMMON"]="普通",["Common"]="普通",["Rare"]="稀有",["LEGENDARY"]="传说",
["Legendary"]="传说",["MYTHIC"]="神话",["Mythic"]="神话",["SECRET"]="秘密",
["Secret"]="秘密",["DIVINE"]="神圣",["Divine"]="神圣",["COSMIC"]="宇宙",
["Cosmic"]="宇宙",["SPECTRAL"]="幽灵",["GOLDEN"]="金色",["SILVER"]="银色",
["EMERALD"]="翡翠",["SAPPHIRE"]="蓝宝石",["AMETHYST"]="紫水晶",["ENCHANTED"]="附魔",
["ETERNAL"]="永恒",["Eternal"]="永恒",["FRACTURED"]="破碎",["Fractured"]="破碎",
["RADIANT"]="光辉",["Radiant"]="光辉",["LUMINOUS"]="辉光",["SKELETAL"]="骸骨",
["ZOMBIFIED"]="僵尸化",["MECHA"]="机甲",["NITRO"]="氮气",["SCRAMBLED"]="混沌",
["CANDY"]="糖果",["CANDY CORN"]="玉米糖",["Candy Corn"]="玉米糖",["ROYAL"]="皇家",
["Nitro Mutation"]="氮气变异",["Spectral Mutation"]="幽灵变异",
["CONFIG"]="配置",["Config"]="配置",["Settings"]="设置",["PROFILES"]="档位",
["Saved profiles"]="已保存档位",["Set active"]="设为当前",
["Set as active config"]="设为当前配置",["New config name"]="新配置名称",
["Create"]="创建",["Craft"]="制作",["Import"]="导入",["Export config"]="导出配置",
["Import text"]="导入文本",["Save"]="保存",["Save spot here"]="在此保存位置",
["Delete"]="删除",["Delete picked"]="删除已选",["Restore deleted"]="恢复已删除",
["Reset to defaults"]="恢复默认设置",["Reset to normal"]="恢复默认",
["DEFAULTS"]="默认设置",["Default"]="默认",["INTERFACE"]="界面",
["Interface"]="界面",["THEME"]="主题",["Icon"]="图标",["Label"]="标签",
["Desc"]="说明",["Show"]="显示",["Clear"]="清除",["Clear eggs"]="清除蛋",
["Copy"]="复制",["Copy invite"]="复制邀请",["Close"]="关闭",["Open"]="打开",
["OPEN"]="打开",["Remove From Hotbar"]="从快捷栏移除",
["Clear all keybinds"]="清除全部快捷键",["Clear all quick bars"]="清除全部快捷栏",
["QUICK BARS"]="快捷栏",["QUICK BAR 1"]="快捷栏 1",["Keybinds"]="快捷键",
["PINS AND KEYBINDS"]="固定与快捷键",["Pinned"]="已固定",["Turn off"]="关闭",
["Turn off all toggles"]="关闭全部开关",["Toggle the backpack."]="开关背包。",
["GAME HUD"]="游戏 HUD",["Hide game UI"]="隐藏游戏界面",
["Hide my pets and eggs"]="隐藏我的宠物和蛋",
["Hide other players' pets and eggs"]="隐藏其他玩家的宠物和蛋",
["Hide sleeping guards"]="隐藏睡眠守卫",["Hide freecam controls"]="隐藏自由视角控制",
["Hide other UI during freecam"]="自由视角时隐藏其他界面",["Hide nameplates"]="隐藏名牌",
["Close Backpack"]="关闭背包",["Dim the game"]="变暗游戏画面",["GRAPHICS"]="画质",
["Low graphics"]="低画质",["FRAME RATE"]="帧率",["FPS cap"]="帧率上限",
["Disable 3D Render"]="禁用 3D 渲染",["OPTIMIZER"]="优化",["Optimizer"]="优化",
["BASES"]="基地",["SFX"]="音效",["Music"]="音乐",["Background Music!"]="背景音乐！",
["Sound Effects!"]="音效！",["NEXT 1"]="下一组 1",["NEXT 2"]="下一组 2",
["NEXT 3"]="下一组 3",["Sort By:"]="排序方式：",["Sort eggs"]="整理蛋",
["Filter"]="筛选",["FILTER"]="筛选",["Search"]="搜索",["Find an option"]="查找选项",
["All"]="全部",["All Items"]="全部物品",["All picked rules"]="所有已选规则",["None"]="无",
["Priority"]="优先",["PRIORITY"]="优先",["PRIORITY ROTATION"]="优先轮换",
["TASK ORDER"]="任务顺序",["Monster order"]="怪物顺序",["Guards to pause"]="暂停的守卫数",
["Guard look"]="守卫外观",["Guard size"]="守卫大小",["Guard speed"]="守卫速度",
["Ignore traps"]="无视陷阱",["Anti guard"]="反守卫",["Anti ragdoll"]="防布娃娃",
["Anti AFK"]="防挂机",["God mode"]="无敌模式",["Infinite jump"]="无限跳",
["Invisible"]="隐身",["Speed"]="速度",["Walk speed"]="行走速度",
["Speed boost"]="速度加成",["Boost speed"]="加速速度",["ESP"]="透视",
["ESP size"]="透视大小",["Egg ESP"]="蛋透视",["Pen egg ESP"]="围栏蛋透视",
["Other pens ESP"]="其他围栏透视",["Player ESP"]="玩家透视",["Guard ESP"]="守卫透视",
["Hit aura"]="打击光环",["HIT AURA"]="打击光环",["Hit who"]="打击对象",
["Enemies and base"]="敌人与基地",["Protection"]="保护",["Move"]="移动",
["MOVEMENT"]="移动",["MOVE"]="移动",["Instant steps"]="瞬移步数",
["Instant steal"]="瞬间偷取",["Instant prompts"]="瞬间提示",["Fishing"]="钓鱼",
["Fishing spot"]="钓鱼点",["Fishing minutes"]="钓鱼时长（分）",
["Treadmill minutes"]="跑步机时长（分）",["Rotate fishing and treadmill"]="钓鱼与跑步机轮换",
["Catch mode"]="捕获模式",["Catch priority"]="捕获优先",["Catch speed"]="捕获速度",
["Chase speed"]="追击速度",["Catch Fireflies"]="抓萤火虫",["Sell"]="出售",
["SELL"]="出售",["Sell Pets"]="出售宠物",["Sell rarities"]="出售稀有度",
["Sell matching eggs now"]="立即出售匹配的蛋",
["Sell matching pets now"]="立即出售匹配的宠物",
["Sell cheapest egg when bag is full"]="背包满时出售最便宜的蛋",
["FAVORITE"]="收藏",["Favorite equipped"]="收藏已装备",["Trade"]="交易",
["TRADE"]="交易",["TRADE UP"]="升级交易",["Smart trade for essence"]="智能交易换取精华",
["Fuse first"]="优先融合",["Fuse Machine"]="融合机",["Mutate eggs"]="变异蛋",
["Mutate first"]="优先变异",["MUTATE FILTER"]="变异筛选",["FUSE FILTER"]="融合筛选",
["MUTATE YOUR EGG"]="给你的蛋变异",["Egg Predictor"]="蛋预测",
["EGG PREDICTOR"]="蛋预测",["EGG SHOWCASE"]="蛋展示",["Steal Panel"]="偷取面板",
["Steal first"]="优先偷取",["Steal filter eggs"]="偷取匹配的蛋",["Steal An Egg"]="偷蛋",
["STEAL EGGS"]="偷蛋",["Steal from other players"]="从其他玩家处偷取",
["Steal panel button on game HUD"]="游戏 HUD 上显示偷取按钮",
["Change if steal fails"]="偷取失败时切换",["After stealing a match"]="偷到一局之后",
["Teleport zones"]="传送区域",["Server hop"]="换服务器",["Rejoin"]="重进服务器",
["Rejoin on kick"]="被踢时重进",["Rejoin this server"]="重进当前服务器",
["JOIN AND STAY"]="加入并停留",["Job ID"]="任务编号",["User ID"]="用户编号",
["Copy Job ID"]="复制任务编号",["Paste a Job ID"]="粘贴任务编号",
["Server Channel: Unknown"]="服务器频道：未知",["WEBHOOK"]="推送",["Webhook"]="推送",
["Webhook URL"]="推送地址",["DISCORD WEBHOOK"]="Discord 推送",["WHAT TO POST"]="推送内容",
["Send a test post"]="发送测试推送",["Post fused eggs"]="发布融合的蛋",
["Post stolen eggs"]="发布偷到的蛋",["Post when bag is full"]="背包满时发布",
["Ping everyone"]="提及所有人",["Ping role ID"]="提及身份组 ID",
["Ping user ID"]="提及用户 ID",["Discord role ID"]="Discord 身份组 ID",
["Discord user ID"]="Discord 用户 ID",["Message"]="消息",
}

local WORDS = {
["auto"]="自动",["farm"]="刷取",["monsters"]="怪物",["monster"]="怪物",["steal"]="偷取",
["fuse"]="融合",["mutate"]="变异",["hatch"]="孵化",["place"]="放置",["sell"]="出售",
["buy"]="购买",["claim"]="领取",["collect"]="收集",["catch"]="捕获",["fish"]="钓鱼",
["fishing"]="钓鱼",["quest"]="任务",["quests"]="任务",["reward"]="奖励",["rewards"]="奖励",
["egg"]="蛋",["eggs"]="蛋",["pet"]="宠物",["pets"]="宠物",["animal"]="动物",
["player"]="玩家",["players"]="玩家",["server"]="服务器",["servers"]="服务器",
["zone"]="区域",["zones"]="区域",["stage"]="阶段",["stages"]="阶段",["mission"]="任务",
["missions"]="任务",["money"]="金钱",["cash"]="现金",["speed"]="速度",["luck"]="幸运",
["size"]="大小",["value"]="价值",["weight"]="重量",["rarity"]="稀有度",
["rarities"]="稀有度",["mastery"]="精通",["essence"]="精华",["crystals"]="水晶",
["crystal"]="水晶",["souls"]="灵魂",["soul"]="灵魂",["tokens"]="代币",
["item"]="物品",["items"]="物品",["inventory"]="背包",["backpack"]="背包",
["bag"]="背包",["name"]="名称",["amount"]="数量",["time"]="时间",["timer"]="计时器",
["ready"]="就绪",["waiting"]="等待",["start"]="开始",["stop"]="停止",["reset"]="重置",
["save"]="保存",["load"]="加载",["import"]="导入",["export"]="导出",["config"]="配置",
["profile"]="档位",["profiles"]="档位",["settings"]="设置",["event"]="活动",
["shop"]="商店",["trail"]="尾迹",["trails"]="尾迹",["mount"]="坐骑",["passes"]="通行证",
["webhook"]="推送",["invite"]="邀请",["guest"]="访客",["guests"]="访客",
["whitelist"]="白名单",["disguise"]="伪装",["guard"]="守卫",["guards"]="守卫",
["prank"]="恶作剧",["announcement"]="公告",["directory"]="目录",["boosts"]="加成",
["boost"]="加成",["protection"]="保护",["anti"]="防",["instant"]="瞬间",
["chance"]="概率",["chances"]="概率",["rotation"]="轮换",["priority"]="优先",
["filter"]="筛选",["equipped"]="已装备",["favorite"]="收藏",["locked"]="未解锁",
["unlocked"]="已解锁",["owned"]="已拥有",["empty"]="空",["full"]="满",
["left"]="剩余",["remaining"]="剩余",["button"]="按钮",["slider"]="滑块",
["input"]="输入框",["panel"]="面板",["window"]="窗口",["menu"]="菜单",
["tab"]="页签",["tabs"]="页签",["close"]="关闭",["open"]="打开",["next"]="下一个",
["back"]="返回",["select"]="选择",["search"]="搜索",["add"]="添加",
["remove"]="移除",["delete"]="删除",["clear"]="清除",["copy"]="复制",
["confirm"]="确认",["cancel"]="取消",["apply"]="应用",["enable"]="启用",
["disable"]="禁用",["get"]="获取",["to"]="到",["same"]="相同",["all"]="全部",
["only"]="仅",["these"]="这些",["this"]="这个",["your"]="你的",["you"]="你",
["is"]="是",["are"]="是",["and"]="和",["or"]="或",["with"]="用",
["while"]="同时",["when"]="当",["if"]="如果",["in"]="在",["from"]="来自",
["for"]="为",["of"]="的",["on"]="开",["off"]="关",["now"]="现在",
["free"]="免费",["bonus"]="奖励",["total"]="总计",["weapons"]="武器",
["weapon"]="武器",["tools"]="工具",["spawn"]="生成",["equip"]="装备",
["unequip"]="卸下",
}

-- ========================= 引擎 =========================
local TAIL = { slider="滑块", button="按钮", input="输入框", toggle="开关", dropdown="下拉框" }
local function isCJK(s) return s:find("[\228-\233]") ~= nil end
local function trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end

local function wordfall(s)
    local changed = false
    local out = s:gsub("(%a+)", function(w)
        local t = WORDS[w:lower()]
        if t then changed = true; return t end
        return w
    end)
    return changed and out or s
end

local function tr(s)
    if type(s) ~= "string" or s == "" or isCJK(s) then return s end
    local hit = DICT[s] or DICT[trim(s)]
    if hit then return hit end
    local inner = s:match("^%-%-%s*(.-)%s*%-%-%s*$")
    if inner then
        local z = DICT[inner] or wordfall(inner)
        if z ~= inner then return "-- " .. z .. " --" end
    end
    local head, mid, tail, close = s:match('^(.-)(%s*<font transparency="0.6">)(.-)(</font>)$')
    if head then
        local h = DICT[head] or head
        local t = TAIL[tail] or DICT[tail] or tail
        if h ~= head or t ~= tail then return h .. mid .. t .. close end
    end
    return wordfall(s)
end

local function fix(o)
    if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then
        pcall(function()
            local t = tr(o.Text)
            if t ~= o.Text then o.Text = t end
        end)
    end
end

local roots = {}
local function addRoot(r) if typeof(r) == "Instance" then roots[#roots + 1] = r end end
local function collectRoots()
    table.clear(roots)
    pcall(function() if gethui then addRoot(gethui()) end end)
    pcall(function() addRoot(game:GetService("CoreGui")) end)
    pcall(function()
        local lp = game:GetService("Players").LocalPlayer
        addRoot(lp and lp:FindFirstChild("PlayerGui"))
    end)
    return #roots
end
local function scanAll()
    for _, r in ipairs(roots) do
        pcall(function() for _, o in ipairs(r:GetDescendants()) do fix(o) end end)
    end
end

-- ========================= 1. 先装钩子 =========================
if CFG.hookFirst then
    local ok = pcall(function()
        assert(type(hookmetamethod) == "function", "无 hookmetamethod")
        local old
        old = hookmetamethod(game, "__newindex", function(self, k, v)
            if type(v) == "string" and (k == "Text" or k == "PlaceholderText") then
                v = tr(v)
            end
            return old(self, k, v)
        end)
    end)
    print(ok and "① 钩子已装好（新建文字直接显示中文）" or "① 钩子安装失败，改用轮询翻译")
end

-- ========================= 2. 加载 Hub =========================
if not game:IsLoaded() then game.Loaded:Wait() end
if CFG.KEY ~= "" then getgenv().script_key = CFG.KEY end

print("② 正在加载 Hub …")
local okHub, errHub = pcall(function()
    local src = game:HttpGet(CFG.HUB_URL)
    if type(src) ~= "string" or #src < 10 then error("下载内容为空") end
    local f = assert(loadstring(src))
    f()
end)
print(okHub and "② Hub 已启动" or ("② Hub 加载失败: " .. tostring(errHub)))

-- ========================= 3. 等界面出现并汉化 =========================
task.spawn(function()
    for i = 1, 3 do
        collectRoots()
        scanAll()
        task.wait(2)
    end
    print("✅ 汉化完成，已停止（钩子仍在，新出现的文字会自动变中文）")
end)
      
    print("③ 汉化开始")

    while CFG.poll and CFG.poll > 0 do
        task.wait(CFG.poll)
        scanAll()
    end
end)

print("✅ 一键脚本已启动：Hub → 汉化，全部自动完成")