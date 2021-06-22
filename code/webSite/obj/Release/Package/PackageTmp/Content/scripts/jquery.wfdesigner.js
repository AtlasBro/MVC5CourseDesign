/*
 * 品码堂出品:
 *   http://www.gxpmt.com
 *
 * Version:  1.0
 *
 */
(function($) {
	//获取到舞台
	var canvas = null;
	//舞台2d绘图接口
	var context = null;
	//获得预览舞台
	var canvasTmp = null;
	//预览舞台2d绘图接口
	var contextTmp = null;

	var defaultOptions = {
		//审批流行号
		rowID: 0,
		//是否响应鼠标事件
		mouseevent: true,
		//响应鼠标双击事件的函数
		dbmousefunction: "",
		//构建工作流的对象
		jsondata: null,
		//高亮的活动节点ID数组
		curactives: null,
		//起始和终止节点的半径
		snradius: 25,
		//活动节点的宽
		activewidth: 100,
		//活动节点的高
		activeheight: 50,
		//路由线条的宽度
		linewidth: 5,
		//起始节点颜色
		bstyle: "#00ff21",
		//终结点颜色
		estyle: "#333",
		//活动节点颜色
		astyle: "#0094ff",
		//拖拽点的颜色
		mstyle: "#666",
		//路由的颜色
		rstyle: "#22c339",
		//活动节点文字颜色
		atstyle: "#fff",
		//路由节点文字颜色
		rtstyle: "#ff0000",
		//文字大小及字体
		ttstyle: "9pt Calibri",
		//选中时的颜色
		sstyle: "#0094FF",
		//高亮显示的颜色
		hightstyle: "#f100fb"
	}
	var options = defaultOptions;

	/*
	 *点对象
	 */
	var Point = function(x, y) {
		//info("创建坐标点对象");
		this.X = x;
		this.Y = y;
	}

	/**
	 * 拖拽点圆形对象
	 */
	var Circular = function(x, y, radius, color) {
		//info("创建圆形点");
		//球的中心点位置
		this.x = x;
		this.y = y;
		//球的半径
		this.radius = radius;
		//球的颜色
		this.color = color;
		//球体颜色
		context.fillStyle = this.color;
		/**
		 * 绘制球
		 */
		this.draw = function() {
			//info("绘制圆形点");
			context.beginPath();
			context.arc(this.x, this.y, this.radius, 0, 2 * Math.PI, false);
			context.fill();
			context.closePath();
		}
	}

	/*
	 *活动节点矩形对象
	 */
	var Rect = function(x, y, id, name) {
		//生成guid
		this.id = id;
		this.name = name || "";
		//矩形的起始点位置
		this.x = x;
		this.y = y;
		//矩形的宽和高
		this.w = options.activewidth;
		this.h = options.activeheight;
		//是否为高亮状态
		this.hightShow = false;

		//定义矩形内的拖拽点
		this.dragRadius = (min(this.w, this.h) - 20) / 2;
		this.centerX = x + this.w / 2;
		this.centerY = y + this.h / 2;

		this.setXY = function(newx, newy) {
			this.x = newx;
			this.y = newy;
			this.centerX = newx + this.w / 2;;
			this.centerY = newy + this.h / 2;
		}
		this.setName = function(name) {
			//info("6");
			this.name = name;
		}
		this.setHightShow = function() {
			//info("7");
			this.hightShow = true;
		}
		/*绘制矩形*/
		this.draw = function() {
			///info("绘制中间节点");
			//矩形颜色
			context.fillStyle = options.astyle;
			if(this.hightShow)
				context.fillStyle = options.hightstyle;
			context.fillRect(this.x, this.y, this.w, this.h);
			//画拖拽点
			var tmpArc = new Circular(this.centerX, this.centerY, this.dragRadius, options.mstyle);
			tmpArc.draw();
			//画名称
			if(this.name != "") {
				context.font = options.ttstyle;
				context.fillStyle = options.atstyle;
				context.textAlign = "center";
				context.fillText(this.name, this.x + this.w / 2, this.y + this.h - 5);
			}
		}
	}
	/*
	 *活动节点矩形移动对象
	 */
	var RectTmp = function(x, y) {
		//矩形的起始点位置
		this.x = x;
		this.y = y;
		//矩形的宽和高
		this.w = options.activewidth;
		this.h = options.activeheight;
		/*绘制矩形*/
		this.draw = function() {
			//矩形颜色
			contextTmp.fillStyle = options.sstyle;
			contextTmp.fillRect(this.x, this.y, this.w, this.h);
		}
	}
	/*
	 *活动节点矩形对象选择时的表现
	 */
	var RectSelect = function(x, y) {
		//info("矩形选中");
		//矩形的起始点位置
		this.x = x - 5;
		this.y = y - 5;
		//矩形的宽和高
		this.w = options.activewidth + 10;
		this.h = options.activeheight + 10;
		/*绘制矩形*/
		this.draw = function() {
			//矩形颜色
			contextTmp.fillStyle = options.sstyle;
			contextTmp.fillRect(this.x, this.y, this.w, this.h);
		}
	}

	/**
	 * -------创建起点对象
	 */
	var BeginPoint = function(x, y, radius, id) {
		//生成guid
		this.id = id || guid();
		//info("创建起点对象"+this.id);
		//定义起始点属性
		this.x = x;
		this.y = y;
		this.radius = radius;

		//拖拽点的半径
		this.dragRadius = this.radius / 2;
		this.centerX = x;
		this.centerY = y;

		this.setXY = function(newx, newy) {
			//info("12");
			this.x = newx;
			this.y = newy;
			this.centerX = newx;
			this.centerY = newy;
		}

		this.draw = function() {

			//info("绘制起始节点");
			context.fillStyle = options.bstyle;
			context.beginPath();
			context.arc(this.x, this.y, this.radius, 0, 2 * Math.PI, false);
			context.fill();
			context.closePath();

			//画拖拽点
			context.fillStyle = options.mstyle;
			context.beginPath();
			context.arc(this.centerX, this.centerY, this.dragRadius, 0, 2 * Math.PI, false);
			context.fill();
			context.closePath();
		}
	}

	/**
	 * -----------创建终结点对象
	 */
	var EndPoint = function(x, y, radius, id) {

		//生成guid
		this.id = id || guid();
		//info("创建结束节点"+this.id);
		//定义起始点属性
		this.x = x;
		this.y = y;
		this.radius = radius;

		//中心点
		this.centerX = x;
		this.centerY = y;

		this.setXY = function(newx, newy) {
			//info("15");
			this.x = newx;
			this.y = newy;
			this.centerX = newx;
			this.centerY = newy;
		}

		this.draw = function() {
			//info("绘制结束节点");
			context.fillStyle = options.estyle;
			context.beginPath();
			context.arc(this.x, this.y, this.radius, 0, 2 * Math.PI, false);
			context.fill();
			context.closePath();
		}
	}

	/**
	 * 起点和终结点的移动对象
	 */
	var BeginEndTmp = function(x, y) {
		//info("17");
		//定义起始点属性
		this.x = x;
		this.y = y;
		this.radius = options.snradius;

		this.draw = function() {
			//info("18");
			contextTmp.fillStyle = options.sstyle;
			contextTmp.beginPath();
			contextTmp.arc(this.x, this.y, this.radius, 0, 2 * Math.PI, false);
			contextTmp.fill();
			contextTmp.closePath();
		}
	}

	/**
	 * 路由箭头对象
	 */
	var Arrow = function(x1, y1, x2, y2, bid, eid, id, type, name) {
		//info("创建箭头对象");
		//生成guid
		this.id = id || guid();
		//路由名称
		this.name = name || "";
		//起始点id
		this.beginID = bid;
		//终结点id
		this.endID = eid;
		//定义起止点属性
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;
		//定义是否已经选择
		this.checked = false;
		//路由属性，0代表单向路由，1代表往返路由的go，2代表往返路由的back
		this.routeType = type || 0;

		this.setXY1 = function(newx, newy) {
			this.x1 = newx;
			this.y1 = newy;
		}
		this.setXY2 = function(newx, newy) {
			this.x2 = newx;
			this.y2 = newy;
		}
		this.setRouteType = function(type) {
			this.routeType = type;
		}
		this.setName = function(name) {
			this.name = name;
		}
		this.draw = function() {
			//info("划线");
			context.lineWidth = options.linewidth; //设置线宽
			context.strokeStyle = options.rstyle; //颜色

			//画箭头主线
			context.beginPath();
			context.moveTo(this.x1, this.y1);
			context.lineTo(this.x2, this.y2);

			//画箭头头部
			var sp = new Point(this.x1, this.y1);
			var ep = new Point(this.x2, this.y2);
			var h = _calcH(sp, ep);
			context.moveTo(ep.X, ep.Y);
			context.lineTo(h.h1.X, h.h1.Y);
			context.moveTo(ep.X, ep.Y);
			context.lineTo(h.h2.X, h.h2.Y);
			context.stroke();
			context.closePath();

			//画名称
			if(this.name != "") {
				context.font = options.ttstyle;
				context.fillStyle = options.rtstyle;
				context.textAlign = "center";
				context.fillText(this.name, (this.x1 + this.x2) / 2, (this.y1 + this.y2) / 2);
			}
		}
		this.setChecked = function(check) {
			//info("21");
			this.checked = check;
			if(check) {
				this.selectDraw();
			} else {
				this.draw();
			}
		}
		this.selectDraw = function() {
			//info("选中路由线");
			//选中时的绘制
			context.lineWidth = options.linewidth; //设置线宽
			context.strokeStyle = options.sstyle; //颜色

			//画箭头主线
			context.beginPath();
			context.moveTo(this.x1, this.y1);
			context.lineTo(this.x2, this.y2);

			//画箭头头部
			var sp = new Point(this.x1, this.y1);
			var ep = new Point(this.x2, this.y2);
			var h = _calcH(sp, ep);
			context.moveTo(ep.X, ep.Y);
			context.lineTo(h.h1.X, h.h1.Y);
			context.moveTo(ep.X, ep.Y);
			context.lineTo(h.h2.X, h.h2.Y);
			context.stroke();
			context.closePath();
		}
	}
	/**
	 * 计算箭头头部坐标
	 */
	var _calcH = function(sp, ep) {
		//info("计算线头坐标");
		//箭头大小，越大箭头边越长
		var arrowSize = 10;
		//箭头锐钝，越小越锐
		var arrowSharp = 6;

		var theta = Math.atan((ep.X - sp.X) / (ep.Y - sp.Y));
		var cep = _scrollXOY(ep, -theta);
		var csp = _scrollXOY(sp, -theta);
		var ch1 = { X: 0, Y: 0 };
		var ch2 = { X: 0, Y: 0 };
		var DS = 1;
		if(cep.Y - csp.Y < 0)
			DS = -1;
		ch1.X = cep.X + DS * arrowSharp;
		ch1.Y = cep.Y - DS * arrowSize;
		ch2.X = cep.X - DS * arrowSharp;
		ch2.Y = cep.Y - DS * arrowSize;
		var h1 = _scrollXOY(ch1, theta);
		var h2 = _scrollXOY(ch2, theta);
		return {
			h1: h1,
			h2: h2
		};
	};
	/**
	 * 旋转坐标
	 */
	var _scrollXOY = function(p, theta) {
		return {
			X: p.X * Math.cos(theta) + p.Y * Math.sin(theta),
			Y: p.Y * Math.cos(theta) - p.X * Math.sin(theta)
		};
	};
	/**
	 * 预览路由箭头对象
	 */
	var ArrowTmp = function(x1, y1, x2, y2) {
		//info("预览箭头");
		//定义起止点属性
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;

		this.draw = function() {
			contextTmp.lineWidth = options.linewidth; //设置线宽
			contextTmp.strokeStyle = options.sstyle; //颜色

			//画箭头主线
			contextTmp.beginPath();
			contextTmp.moveTo(this.x1, this.y1);
			contextTmp.lineTo(this.x2, this.y2);

			//画箭头头部
			var sp = new Point(this.x1, this.y1);
			var ep = new Point(this.x2, this.y2);
			var h = _calcH(sp, ep);
			contextTmp.moveTo(ep.X, ep.Y);
			contextTmp.lineTo(h.h1.X, h.h1.Y);
			contextTmp.moveTo(ep.X, ep.Y);
			contextTmp.lineTo(h.h2.X, h.h2.Y);
			contextTmp.stroke();
			contextTmp.closePath();
		}
	}

	/**
	 * 往返路由对象
	 */
	var GoBackRoute = function() {
		this.goRoute = null;
		this.backRoute = null;
		this.setGo = function(go) {
			this.goRoute = go;
		}
		this.setBack = function(back) {
			this.backRoute = back;
		}
	}

	//创建起始点
	var begin = null;

	//创建终结点
	var end = null;

	//活动节点序列
	var elementList = [];
	//路由序列
	var routeList = [];

	/*
	 *重绘函数
	 */
	function reDrawDesigner() {
		//info("重新绘制画布");
		//清除画布
		context.clearRect(0, 0, canvas.width, canvas.height);

		//绘制起始和终结点
		begin.draw();
		end.draw();

		//绘制活动节点
		for(var i = 0; i < elementList.length; i++) {
			elementList[i].draw();
		}

		//绘制路由
		for(var i = 0; i < routeList.length; i++) {
			routeList[i].draw();
		}
	}

	/****************************获取鼠标在画布内的坐标*****************************/
	function getMousePos(canvas, evt) {
		var obj = canvas;
		var top = 0;
		var left = 0;
		while(obj && obj.tagName != 'BODY') {
			top += obj.offsetTop;
			left += obj.offsetLeft;
			obj = obj.offsetParent;
		}
		var evt = evt || window.event;
		var mouseX = evt.clientX - left + window.pageXOffset;
		var mouseY = evt.clientY - top + window.pageYOffset;
		return { x: mouseX, y: mouseY };
	}

	/****************************计算点是否在多边形内*****************************/
	function min(x, y) {
		if(x > y)
			return y;
		else
			return x;
	}

	function max(x, y) {
		if(x > y)
			return x;
		else
			return y;
	}

	function PtInPolygon(p, ptPolygon) {
		var nCount = ptPolygon.length;
		var isBeside = false; // 记录是否在多边形的边上

		//矩形外区域
		var maxx;
		var maxy;
		var minx;
		var miny;
		if(nCount > 0) {
			maxx = ptPolygon[0].X;
			minx = ptPolygon[0].X;
			maxy = ptPolygon[0].Y;
			miny = ptPolygon[0].Y;

			for(var j = 1; j < nCount; j++) {
				if(ptPolygon[j].X >= maxx)
					maxx = ptPolygon[j].X;
				else if(ptPolygon[j].X <= minx)
					minx = ptPolygon[j].X;

				if(ptPolygon[j].Y >= maxy)
					maxy = ptPolygon[j].Y;
				else if(ptPolygon[j].Y <= miny)
					miny = ptPolygon[j].Y;
			}

			if((p.X > maxx) || (p.X < minx) || (p.Y > maxy) || (p.Y < miny))
				return -1;
		}

		//射线法
		var nCross = 0;

		for(var i = 0; i < nCount; i++) {
			var p1 = new Point(ptPolygon[i].X, ptPolygon[i].Y);
			var mod = (i + 1) % nCount;
			var p2 = new Point(ptPolygon[mod].X, ptPolygon[mod].Y);
			// 求解 y=p.y 与 p1p2 的交点

			if(p1.Y == p2.Y) // p1p2 与 y=p0.y平行 
			{
				if(p.Y == p1.Y && p.X >= min(p1.X, p2.X) && p.X <= max(p1.X, p2.X)) {
					isBeside = true;
					continue;
				}
			}

			if(p.Y < min(p1.Y, p2.Y) || p.Y > max(p1.Y, p2.Y)) // 交点在p1p2延长线上 
				continue;

			// 求交点的 X 坐标 -------------------------------------------------------------- 
			var x = (p.Y - p1.Y) * (p2.X - p1.X) / (p2.Y - p1.Y) + p1.X;

			if(x > p.X)
				nCross++; // 只统计单边交点 
			else if(x == p.X)
				isBeside = true;
		}

		if(isBeside)
			return 0; //多边形边上
		else if(nCross % 2 == 1) // 单边交点为偶数，点在多边形之外 --- 
			return 1; //多边形内

		return -1; //多边形外
	}
	//判断给定的点是否在给定的点组成的多边型内
	function IsPtInPolygon(pt, points) {
		var isIn = PtInPolygon(pt, points);
		if(isIn >= 0)
			return(true);
		else
			return(false);
	}

	/****************************判断给定的坐标点是否在指定圆的范围内*****************************/
	function isInArc(point, x, y, radius) {
		var dx = point.X - x;
		var dy = point.Y - y;
		var len = Math.sqrt(dx * dx + dy * dy);
		if(Math.abs(len) <= radius)
			return(true);
		else
			return(false);
	}

	/****************************判断给定点 pt 是否在两点直线上*****************************/
	function IsPtInLine(pt, startPoint, endPoint, allowError) {
		//如果选择的点与当前点重合
		//线段尾部单击
		if(Math.abs(endPoint.X - pt.X) <= allowError && Math.abs(endPoint.Y - pt.Y) <= allowError)
			return true;

		//线段之间单击
		if(Math.min(startPoint.X, endPoint.X) <= pt.X && Math.min(startPoint.Y, endPoint.Y) <= pt.Y && Math.max(startPoint.X, endPoint.X) >= pt.X && Math.max(startPoint.Y, endPoint.Y) >= pt.Y) {
			//精确匹配判断的话
			if(Math.abs(allowError - 0.0) <= 0.0001) {
				var tp1 = new Point(endPoint.X - pt.X, endPoint.Y - pt.Y); //矢量减法
				var tp2 = new Point(pt.X - startPoint.X, pt.Y - startPoint.Y); //矢量减法

				if(Math.abs(Math.abs(tp1.X * tp2.Y - tp2.X * tp1.Y) - 0.0) <= 0.00000001) //矢量叉乘,平行四边形的面积
					return true;
			} else {
				if(Math.abs(endPoint.X - startPoint.X) <= allowError && Math.abs(endPoint.X - pt.X) <= allowError)
					return true;

				if(Math.abs(endPoint.Y - startPoint.Y) <= allowError && Math.abs(endPoint.Y - pt.Y) <= allowError)
					return true;

				if(DistancePointToSegment(pt, startPoint, endPoint) <= allowError)
					return true;

				//如果点到线段的距离在容差范围内,则选取成功
				if(DistancePointToSegment(pt, startPoint, endPoint) <= allowError)
					return true;
			}
		}
		return false;
	}
	//计算点到线段(a,b)的距离
	function DistancePointToSegment(P, A, B) {
		var l = 0.0;
		var s = 0.0;
		l = DistancePointToPoint(A, B);
		s = ((A.Y - P.Y) * (B.X - A.X) - (A.X - P.X) * (B.Y - A.Y)) / (l * l);
		return(Math.abs(s * l));
	}
	//计算点到点的距离
	function DistancePointToPoint(ptA, ptB) {
		return Math.sqrt(Math.pow(ptA.X - ptB.X, 2) + Math.pow(ptA.Y - ptB.Y, 2));
	}

	/****************************生成guid字符串*****************************/
	function guid() {
		function S4() {
			return(((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
		}
		return(S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
	}

	/****************************判断是否已经存在路由*****************************/
	function isInRoute(bid, eid) {
		var isin = false;
		for(var i = 0; i < routeList.length; i++) {
			if(routeList[i].beginID == bid && routeList[i].endID == eid) {
				isin = true;
				break;
			}
		}
		return(isin);
	}

	/****************************如果两个活动节点存在往返路由，则返回往返路由对象，否则返回null*****************************/
	function getGoBackRoute(ele1, ele2) {
		var isgo = false;
		var isback = false;
		var goBackRoute = new GoBackRoute();
		for(var i = 0; i < routeList.length; i++) {
			if(routeList[i].beginID == ele1.id && routeList[i].endID == ele2.id) {
				isgo = true;
				goBackRoute.setGo(routeList[i]);
			}
			if(routeList[i].endID == ele1.id && routeList[i].beginID == ele2.id) {
				isback = true;
				goBackRoute.setBack(routeList[i]);
			}
			if(isgo && isback)
				break;
		}
		if(isgo && isback)
			return(goBackRoute);
		else
			return(null);
	}

	/****************************获取指定id的活动节点对象*****************************/
	function getElementByID(id) {
		for(var i = 0; i < elementList.length; i++) {
			if(id == elementList[i].id)
				return(elementList[i]);
		}
	}

	/****************************返回矩形外点投射到矩形中心的边上的坐标*****************************/
	function GetPointAtRectangle(star, end, width, height) {
		var returnPoint = new Point(0, 0);
		if(star.X == end.X) {
			returnPoint.X = star.X;
			if(end.Y <= star.Y)
				returnPoint.Y = star.Y - height / 2;
			else
				returnPoint.Y = star.Y + height / 2;
		} else if(star.Y == end.Y) {
			returnPoint.Y = star.Y;
			if(end.X <= star.X)
				returnPoint.X = star.X - width / 2;
			else
				returnPoint.X = star.X + width / 2;
		} else {
			if(height / width >= Math.abs(end.Y - star.Y) / Math.abs(end.X - star.X)) {
				if(end.X - star.X <= 0) {
					returnPoint.X = star.X - width / 2;
					returnPoint.Y = star.Y + (end.Y - star.Y) * (-width / 2) / (end.X - star.X);
				} else {
					returnPoint.X = star.X + width / 2;
					returnPoint.Y = star.Y + (end.Y - star.Y) * (width / 2) / (end.X - star.X);
				}
			} else {
				if(end.Y - star.Y <= 0) {
					returnPoint.Y = star.Y - height / 2;
					returnPoint.X = (-height / 2) * (end.X - star.X) / (end.Y - star.Y) + star.X;
				} else {
					returnPoint.Y = star.Y + height / 2;
					returnPoint.X = (height / 2) * (end.X - star.X) / (end.Y - star.Y) + star.X;
				}
			}
		}
		return(returnPoint);
	}

	/****************************返回圆外点投射到圆心的圆边上坐标*****************************/
	function GetPointAtEllipse(star, end, r) {
		var returnPoint = new Point(0, 0);
		if(star.X == end.X) {
			returnPoint.X = star.X;
			if(end.Y <= star.Y)
				returnPoint.Y = star.Y - r;
			else
				returnPoint.Y = star.Y + r;
		} else if(star.Y == end.Y) {
			returnPoint.Y = star.Y;
			if(end.X <= star.X)
				returnPoint.X = star.X - r;
			else
				returnPoint.X = star.X + r;
		} else {
			returnPoint.Y = r * (end.Y - star.Y) / Math.sqrt(Math.pow(end.Y - star.Y, 2) + Math.pow(end.X - star.X, 2)) + star.Y;
			returnPoint.X = (returnPoint.Y - star.Y) * (end.X - star.X) / (end.Y - star.Y) + star.X;
		}
		return(returnPoint);
	}

	/****************************根据两活动的中心点，返回往返的边缘坐标*****************************/
	function GoBackPoint(star, end, r, bid, width, height) {
		//获取新的起点
		var newStart = GetBidPoint(star, end, r, bid, true);
		//获取新的终点
		var newEnd = GetBidPoint(star, end, r, bid, false);

		var intersection = [];
		intersection.push(new Point(0, 0));
		intersection.push(new Point(0, 0));
		if(newStart.X == newEnd.X) {
			if(newStart.Y >= newEnd.Y) {
				intersection[0].X = newStart.X;
				intersection[0].Y = newStart.Y - height / 2;
				intersection[1].X = newEnd.X;
				intersection[1].Y = newEnd.Y + height / 2;
			} else {
				intersection[0].X = newStart.X;
				intersection[0].Y = newStart.Y + height / 2;
				intersection[1].X = newEnd.X;
				intersection[1].Y = newEnd.Y - height / 2;
			}
		} else if(newStart.Y == newEnd.Y) {
			if(newStart.X >= newEnd.X) {
				intersection[0].X = newStart.X - width / 2;
				intersection[0].Y = newStart.Y;
				intersection[1].X = newEnd.X + width / 2;
				intersection[1].Y = newEnd.Y;
			} else {
				intersection[0].X = newStart.X + width / 2;
				intersection[0].Y = newStart.Y;
				intersection[1].X = newEnd.X - width / 2;
				intersection[1].Y = newEnd.Y;
			}
		} else {
			//定义起点的四个角的坐标
			var Srec1 = new Point(star.X - width / 2, star.Y - height / 2); //左上角
			var Srec2 = new Point(star.X + width / 2, star.Y - height / 2); //右上角
			var Srec3 = new Point(star.X + width / 2, star.Y + height / 2); //右下角
			var Srec4 = new Point(star.X - width / 2, star.Y + height / 2); //左下角

			//定义交叉点落在哪条边上
			var Lin1 = 0; //0为上边，1为右边，2为下边，3为左边

			//定义结束点点的四个角的坐标
			var Erec1 = new Point(end.X - width / 2, end.Y - height / 2); //左上角
			var Erec2 = new Point(end.X + width / 2, end.Y - height / 2); //右上角
			var Erec3 = new Point(end.X + width / 2, end.Y + height / 2); //右下角
			var Erec4 = new Point(end.X - width / 2, end.Y + height / 2); //左下角

			//定义交叉点落在哪条边上
			var Lin2 = 0; //0为上边，1为右边，2为下边，3为左边

			if(newStart.Y < newEnd.Y) {
				if(newStart.X > newEnd.X) {
					if(Math.abs((newStart.Y - newEnd.Y) / (newStart.X - newEnd.X)) >= Math.abs((newStart.Y - Srec4.Y) / (newStart.X - Srec4.X)))
						Lin1 = 2;
					else
						Lin1 = 3;
				} else {
					if(Math.abs((newStart.Y - newEnd.Y) / (newStart.X - newEnd.X)) >= Math.abs((newStart.Y - Srec3.Y) / (newStart.X - Srec3.X)))
						Lin1 = 2;
					else
						Lin1 = 1;
				}

				if(newStart.X > newEnd.X) {
					if(Math.abs((newEnd.Y - newStart.Y) / (newEnd.X - newStart.X)) >= Math.abs((newEnd.Y - Erec2.Y) / (newEnd.X - Erec2.X)))
						Lin2 = 0;
					else
						Lin2 = 1;
				} else {
					if(Math.abs((newEnd.Y - newStart.Y) / (newEnd.X - newStart.X)) >= Math.abs((newEnd.Y - Erec1.Y) / (newEnd.X - Erec1.X)))
						Lin2 = 0;
					else
						Lin2 = 3;
				}
			} else {
				if(newStart.X > newEnd.X) {
					if(Math.abs((newEnd.Y - newStart.Y) / (newEnd.X - newStart.X)) >= Math.abs((newStart.Y - Srec1.Y) / (newStart.X - Srec1.X)))
						Lin1 = 0;
					else
						Lin1 = 3;
				} else {
					if(Math.abs((newEnd.Y - newStart.Y) / (newEnd.X - newStart.X)) >= Math.abs((newStart.Y - Srec2.Y) / (newStart.X - Srec2.X)))
						Lin1 = 0;
					else
						Lin1 = 1;
				}

				if(newStart.X > newEnd.X) {
					if(Math.abs((newStart.Y - newEnd.Y) / (newStart.X - newEnd.X)) >= Math.abs((newEnd.Y - Erec3.Y) / (newEnd.X - Erec3.X)))
						Lin2 = 2;
					else
						Lin2 = 1;
				} else {
					if(Math.abs((newStart.Y - newEnd.Y) / (newStart.X - newEnd.X)) >= Math.abs((newEnd.Y - Erec4.Y) / (newEnd.X - Erec4.X)))
						Lin2 = 2;
					else
						Lin2 = 3;
				}
			}

			var point1 = newStart;
			var point2 = newEnd;
			var point3 = new Point(0, 0);
			var point4 = new Point(0, 0);
			switch(Lin1) {
				case 0:
					{
						point3 = Srec1;
						point4 = Srec2;
						break;
					}
				case 1:
					{
						point3 = Srec2;
						point4 = Srec3;
						break;
					}
				case 2:
					{
						point3 = Srec3;
						point4 = Srec4;
						break;
					}
				case 3:
					{
						point3 = Srec4;
						point4 = Srec1;
						break;
					}
			}

			intersection[0] = Interaction(point1, point2, point3, point4);
			if(intersection[0] == new Point(0, 0))
				intersection[0] = newStart;
			switch(Lin2) {
				case 0:
					{
						point3 = Erec1;
						point4 = Erec2;
						break;
					}
				case 1:
					{
						point3 = Erec2;
						point4 = Erec3;
						break;
					}
				case 2:
					{
						point3 = Erec3;
						point4 = Erec4;
						break;
					}
				case 3:
					{
						point3 = Erec4;
						point4 = Erec1;
						break;
					}
			}
			intersection[1] = Interaction(point1, point2, point3, point4);
			if(intersection[1] == new Point(0, 0))
				intersection[1] = newEnd;
		}
		return(intersection);
	}

	function Interaction(point1, point2, point3, point4) {
		var intersection = new Point(0, 0);
		//k为intersection(交点)到point1的距离除以point1到point2的距离,k<0表明intersection在point1之外,k>1表明intersection在point2之外
		var k = ((point1.Y - point4.Y) * (point3.X - point4.X) - (point1.X - point4.X) * (point3.Y - point4.Y)) / ((point2.X - point1.X) * (point3.Y - point4.Y) - (point2.Y - point1.Y) * (point3.X - point4.X));
		if(k >= 0 && k <= 1) {
			intersection.X = point1.X + (point2.X - point1.X) * k;
			intersection.Y = point1.Y + (point2.Y - point1.Y) * k;
		}
		return(intersection);
	}

	function GetBidPoint(star, end, r, bid, SorE) {
		var returnPoint = new Point(0, 0);
		var beginPoint = new Point(0, 0);
		if(SorE)
			beginPoint = star;
		else
			beginPoint = end;
		if(star.X == end.X && star.Y == end.Y) {
			returnPoint.X = star.X + r;
			returnPoint.Y = star.Y;
		} else {
			if(bid == 1) {
				if(star.X >= end.X && star.Y > end.Y) {
					returnPoint.X = beginPoint.X + Math.sqrt(Math.pow(r, 2) * Math.pow(star.Y - end.Y, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(star.X - end.X, 2)));
					returnPoint.Y = beginPoint.Y - Math.sqrt(Math.pow(r, 2) * Math.pow(star.X - end.X, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(star.X - end.X, 2)));
				} else if(star.X < end.X && star.Y > end.Y) {
					returnPoint.X = beginPoint.X + Math.sqrt(Math.pow(r, 2) * Math.pow(star.Y - end.Y, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(star.X - end.X, 2)));
					returnPoint.Y = beginPoint.Y + Math.sqrt(Math.pow(r, 2) * Math.pow(star.X - end.X, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(star.X - end.X, 2)));
				} else if(star.X < end.X && star.Y <= end.Y) {
					returnPoint.X = beginPoint.X - Math.sqrt(Math.pow(r, 2) * Math.pow(star.Y - end.Y, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(star.X - end.X, 2)));
					returnPoint.Y = beginPoint.Y + Math.sqrt(Math.pow(r, 2) * Math.pow(star.X - end.X, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(star.X - end.X, 2)));
				} else {
					returnPoint.X = beginPoint.X - Math.sqrt(Math.pow(r, 2) * Math.pow(star.Y - end.Y, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(star.X - end.X, 2)));
					returnPoint.Y = beginPoint.Y - Math.sqrt(Math.pow(r, 2) * Math.pow(star.X - end.X, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(star.X - end.X, 2)));
				}
			} else {
				if(star.X <= end.X && star.Y <= end.Y) {
					returnPoint.X = beginPoint.X - Math.sqrt(Math.pow(r, 2) * Math.pow(end.Y - star.Y, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(end.X - star.X, 2)));
					returnPoint.Y = beginPoint.Y + Math.sqrt(Math.pow(r, 2) * Math.pow(end.X - star.X, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(end.X - star.X, 2)));
				} else if(star.X > end.X && star.Y <= end.Y) {
					returnPoint.X = beginPoint.X - Math.sqrt(Math.pow(r, 2) * Math.pow(end.Y - star.Y, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(end.X - star.X, 2)));
					returnPoint.Y = beginPoint.Y - Math.sqrt(Math.pow(r, 2) * Math.pow(end.X - star.X, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(end.X - star.X, 2)));
				} else if(star.X > end.X && star.Y > end.Y) {
					returnPoint.X = beginPoint.X + Math.sqrt(Math.pow(r, 2) * Math.pow(end.Y - star.Y, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(end.X - star.X, 2)));
					returnPoint.Y = beginPoint.Y - Math.sqrt(Math.pow(r, 2) * Math.pow(end.X - star.X, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(end.X - star.X, 2)));
				} else {
					returnPoint.X = beginPoint.X + Math.sqrt(Math.pow(r, 2) * Math.pow(end.Y - star.Y, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(end.X - star.X, 2)));
					returnPoint.Y = beginPoint.Y + Math.sqrt(Math.pow(r, 2) * Math.pow(end.X - star.X, 2) / (Math.pow(star.Y - end.Y, 2) + Math.pow(end.X - star.X, 2)));
				}
			}
		}
		return(returnPoint);
	}

	/****************************检查工作流的完整性*****************************/
	function checkWF() {
		var msg = "";
		//检查起始点和终结点是否有路由
		var isBegin = false;
		var isEnd = false;
		for(var i = 0; i < routeList.length; i++) {
			if(routeList[i].beginID == begin.id)
				isBegin = true;
			if(routeList[i].endID == end.id)
				isEnd = true;
			if(isBegin && isEnd)
				break;
		}
		if(!isBegin || !isEnd) {
			msg = "起始点或终结点还没有设置路由";
			return msg;
		}

		//检查活动节点是否都有进出路由
		for(var i = 0; i < elementList.length; i++) {
			isBegin = false;
			isEnd = false;
			for(var n = 0; n < routeList.length; n++) {
				if(elementList[i].id == routeList[n].beginID)
					isBegin = true;
				if(elementList[i].id == routeList[n].endID)
					isEnd = true;
				if(isBegin && isEnd)
					break;
			}
			if(!isBegin || !isEnd)
				break;
		}
		if(!isBegin || !isEnd)
			msg = "有些活动节点缺少进或者出的路由";
		return msg;
	}

	//画布的鼠标事件
	var isDown = false;
	var currentElement = null; //选中的元素
	var offPoint = null; //鼠标点击的坐标与元素起始点的偏移量
	var isDrag = false; //是否选中的是拖拽点
	var isClick = true; //是点击还是移动
	function OnMouseDown(evt) {
		//info("鼠标按下");
		var mouseX = getMousePos(canvas, evt).x;
		var mouseY = getMousePos(canvas, evt).y;
		var mousePoint = new Point(mouseX, mouseY);

		//先置当前选中元素为null
		currentElement = null;
		isClick = true;

		if(isInArc(mousePoint, begin.x, begin.y, begin.radius)) {
			//info("选中起始结点" + begin.id);

			//请求服务器
			if($("#wfEdit").length > 0) {
				ajaxHtml("selectNode", { nodeID: begin.id }, function(data) {
					$("#wfEdit").html(data);
					setDialogCSS();
				});
			}

			//判断是否点中起始节点
			currentElement = begin;
			offPoint = new Point(mousePoint.X - currentElement.x, mousePoint.Y - currentElement.y);
			//是否点中起始点的拖拽点
			if(isInArc(mousePoint, begin.centerX, begin.centerY, begin.dragRadius)) {
				//info("点中起始结点拖拽点");
				isDrag = true;
			}
		} else if(isInArc(mousePoint, end.x, end.y, end.radius)) {
			//info("选中结束节点" + end.id);

			//请求服务器
			if($("#wfEdit").length > 0) {
				ajaxHtml("selectNode", { nodeID: end.id }, function(data) {
					$("#wfEdit").html(data);
					setDialogCSS();
				});
			}

			//判断是否点中终结节点
			currentElement = end;
			offPoint = new Point(mousePoint.X - currentElement.x, mousePoint.Y - currentElement.y);
		} else {

			//否则判断是否点中活动节点
			for(var i = 0; i < elementList.length; i++) {
				var tmpPoints = [];
				var point1 = new Point(elementList[i].x, elementList[i].y);
				tmpPoints.push(point1);
				var point2 = new Point(elementList[i].x + elementList[i].w, elementList[i].y);
				tmpPoints.push(point2);
				var point3 = new Point(elementList[i].x + elementList[i].w, elementList[i].y + elementList[i].h);
				tmpPoints.push(point3);
				var point4 = new Point(elementList[i].x, elementList[i].y + elementList[i].h);
				tmpPoints.push(point4);
				if(IsPtInPolygon(mousePoint, tmpPoints)) {
					currentElement = elementList[i];
					//info("选中中间节点" + currentElement.id);

					//请求服务器
					if($("#wfEdit").length > 0) {
						ajaxHtml("selectNode", { nodeID: currentElement.id }, function(data) {
							$("#wfEdit").html(data);
							setDialogCSS();
						});
					}

					offPoint = new Point(mousePoint.X - currentElement.x, mousePoint.Y - currentElement.y);
					//是否点中活动节点的拖拽点
					if(isInArc(mousePoint, currentElement.centerX, currentElement.centerY, currentElement.dragRadius)) {
						//info("点中中间节点拖拽点");
						isDrag = true;
					}
					break;
				}
			}
		}
		//如果有点中的节点
		if(currentElement != null) {
			isDown = true;
		} else {
			isDown = false;
		}
	}

	//鼠标事件
	function OnMouseMove(evt) {
		//info("鼠标移动");
		isClick = false;
		if(isDown && currentElement != null) {
			contextTmp.clearRect(0, 0, canvasTmp.width, canvasTmp.height);
			var mouseX = getMousePos(canvas, evt).x;
			var mouseY = getMousePos(canvas, evt).y;
			if(!isDrag) {
				//移动元素
				currentElement.setXY(mouseX - offPoint.X, mouseY - offPoint.Y);
				if(currentElement == begin || currentElement == end) { //移动的是起始点或终结点
					var betmp = new BeginEndTmp(mouseX - offPoint.X, mouseY - offPoint.Y);
					betmp.draw();
				} else {
					//移动的是活动节点
					var rectmp = new RectTmp(mouseX - offPoint.X, mouseY - offPoint.Y);
					rectmp.draw();
				}
			} else {
				//选中的是拖拽点，画虚拟路由
				//画预览路由箭头
				var routeTmp = new ArrowTmp(currentElement.centerX, currentElement.centerY, mouseX, mouseY);
				routeTmp.draw();
			}
		}
	}
	//鼠标抬起，清空画布，重新绘制所有元素
	function OnMouseUp(evt) {
		//info("鼠标抬起");
		//清除预览画布
		contextTmp.clearRect(0, 0, canvasTmp.width, canvasTmp.height);

		if(isDown && currentElement != null) { //如果选择有元素
			if(isDrag) {
				//画路由
				var mouseX = getMousePos(canvas, evt).x;
				var mouseY = getMousePos(canvas, evt).y;
				var mousePoint = new Point(mouseX, mouseY);
				if(isInArc(mousePoint, end.x, end.y, end.radius) && currentElement != end) {
					//判断是否点中终结节点
					if(!isInRoute(currentElement.id, end.id)) {
						//画路由箭头
						var starp = null;
						if(currentElement == begin)
							starp = GetPointAtEllipse(new Point(currentElement.centerX, currentElement.centerY), new Point(end.centerX, end.centerY), currentElement.radius);
						else
							starp = GetPointAtRectangle(new Point(currentElement.centerX, currentElement.centerY), new Point(end.centerX, end.centerY), currentElement.w, currentElement.h);
						var endp = GetPointAtEllipse(new Point(end.centerX, end.centerY), new Point(currentElement.centerX, currentElement.centerY), end.radius);
						var route = new Arrow(starp.X, starp.Y, endp.X, endp.Y, currentElement.id, end.id);
						route.draw();
						routeList.push(route);

						//info("画向结束节点的线条:" + route.id);
						//info("创建线条2开始:" + currentElement.id);
						//info("创建线条2结束:" + end.id);

						//提交服务器
						ajaxPost("createRoute", { rowID: options.rowID, guidID: route.id, startID: currentElement.id, endID: end.id }, function(data) {
							showJsonResult(data);
						});
					}
				} else {
					//否则判断是否点中活动节点
					for(var i = 0; i < elementList.length; i++) {
						var tmpPoints = [];
						var point1 = new Point(elementList[i].x, elementList[i].y);
						tmpPoints.push(point1);
						var point2 = new Point(elementList[i].x + elementList[i].w, elementList[i].y);
						tmpPoints.push(point2);
						var point3 = new Point(elementList[i].x + elementList[i].w, elementList[i].y + elementList[i].h);
						tmpPoints.push(point3);
						var point4 = new Point(elementList[i].x, elementList[i].y + elementList[i].h);
						tmpPoints.push(point4);
						if(IsPtInPolygon(mousePoint, tmpPoints) && currentElement != elementList[i]) {
							if(!isInRoute(currentElement.id, elementList[i].id)) {
								//画路由箭头
								var starp = null;
								if(currentElement == begin)
									starp = GetPointAtEllipse(new Point(currentElement.centerX, currentElement.centerY), new Point(elementList[i].centerX, elementList[i].centerY), currentElement.radius);
								else
									starp = GetPointAtRectangle(new Point(currentElement.centerX, currentElement.centerY), new Point(elementList[i].centerX, elementList[i].centerY), currentElement.w, currentElement.h);
								var endp = GetPointAtRectangle(new Point(elementList[i].centerX, elementList[i].centerY), new Point(currentElement.centerX, currentElement.centerY), elementList[i].w, elementList[i].h);
								var route = new Arrow(starp.X, starp.Y, endp.X, endp.Y, currentElement.id, elementList[i].id);
								route.draw();
								routeList.push(route);

								//info("画向中间节点的线条:" + route.id);
								//info("创建线条1开始：" + currentElement.id);
								//info("创建划线1结束:" + elementList[i].id);

								//提交服务器
								ajaxPost("createRoute", { rowID: options.rowID, guidID: route.id, startID: currentElement.id, endID: elementList[i].id }, function(data) {
									showJsonResult(data);
								});

								//判断两个活动节点是否有往返路由，如果有，则需要修改往返路由的坐标
								if(currentElement != begin) {
									var gbroute = getGoBackRoute(currentElement, elementList[i]);
									if(gbroute != null) {
										//开始做修改往返路由坐标的修改操作，做完后，对画布进行重画操作。
										var beginElement = getElementByID(gbroute.goRoute.beginID);
										var endElement = getElementByID(gbroute.goRoute.endID);
										var gbpoints = GoBackPoint(new Point(beginElement.centerX, beginElement.centerY), new Point(endElement.centerX, endElement.centerY), beginElement.dragRadius, 1, beginElement.w, beginElement.h);
										gbroute.goRoute.setXY1(gbpoints[0].X, gbpoints[0].Y);
										gbroute.goRoute.setXY2(gbpoints[1].X, gbpoints[1].Y);
										gbroute.goRoute.setRouteType(1);
										gbpoints = GoBackPoint(new Point(endElement.centerX, endElement.centerY), new Point(beginElement.centerX, beginElement.centerY), endElement.dragRadius, 2, endElement.w, endElement.h);
										gbroute.backRoute.setXY1(gbpoints[0].X, gbpoints[0].Y);
										gbroute.backRoute.setXY2(gbpoints[1].X, gbpoints[1].Y);
										gbroute.backRoute.setRouteType(2);
										//重绘画布
										reDrawDesigner();
									}
								}
							}
							break;
						}
					}
				}
			} else { //如果是移动元素，则先对路由进行坐标重新调正，然后再进行重绘
				for(var i = 0; i < routeList.length; i++) {
					if(routeList[i].beginID == currentElement.id || routeList[i].endID == currentElement.id) {
						//获取起始点元素
						var beginElement = null;
						if(routeList[i].beginID == begin.id)
							beginElement = begin;
						else
							beginElement = getElementByID(routeList[i].beginID);
						//获取终结点元素
						var endElement = null;
						if(routeList[i].endID == end.id)
							endElement = end;
						else
							endElement = getElementByID(routeList[i].endID);

						var starp = null;
						var endp = null;
						if(currentElement == begin) { //如果当前移动的是起始点
							starp = GetPointAtEllipse(new Point(currentElement.centerX, currentElement.centerY), new Point(endElement.centerX, endElement.centerY), currentElement.radius);
							routeList[i].setXY1(starp.X, starp.Y);
							if(endElement == end)
								endp = GetPointAtEllipse(new Point(endElement.centerX, endElement.centerY), new Point(currentElement.centerX, currentElement.centerY), endElement.radius);
							else
								endp = GetPointAtRectangle(new Point(endElement.centerX, endElement.centerY), new Point(currentElement.centerX, currentElement.centerY), endElement.w, endElement.h);
							routeList[i].setXY2(endp.X, endp.Y);
						} else if(currentElement == end) { //如果当前移动的是终结点
							endp = GetPointAtEllipse(new Point(currentElement.centerX, currentElement.centerY), new Point(beginElement.centerX, beginElement.centerY), currentElement.radius);
							routeList[i].setXY2(endp.X, endp.Y);
							if(beginElement == begin)
								starp = GetPointAtEllipse(new Point(beginElement.centerX, beginElement.centerY), new Point(currentElement.centerX, currentElement.centerY), beginElement.radius);
							else
								starp = GetPointAtRectangle(new Point(beginElement.centerX, beginElement.centerY), new Point(currentElement.centerX, currentElement.centerY), beginElement.w, beginElement.h);
							routeList[i].setXY1(starp.X, starp.Y);
						} else { //否则为活动节点
							if(routeList[i].routeType == 0) { //单向路由的情况
								if(beginElement == currentElement) {
									starp = GetPointAtRectangle(new Point(currentElement.centerX, currentElement.centerY), new Point(endElement.centerX, endElement.centerY), currentElement.w, currentElement.h);
									routeList[i].setXY1(starp.X, starp.Y);
									if(endElement == end)
										endp = GetPointAtEllipse(new Point(endElement.centerX, endElement.centerY), new Point(currentElement.centerX, currentElement.centerY), endElement.radius);
									else
										endp = GetPointAtRectangle(new Point(endElement.centerX, endElement.centerY), new Point(currentElement.centerX, currentElement.centerY), endElement.w, endElement.h);
									routeList[i].setXY2(endp.X, endp.Y);
								} else {
									if(beginElement == begin)
										starp = GetPointAtEllipse(new Point(beginElement.centerX, beginElement.centerY), new Point(currentElement.centerX, currentElement.centerY), beginElement.radius);
									else
										starp = GetPointAtRectangle(new Point(beginElement.centerX, beginElement.centerY), new Point(currentElement.centerX, currentElement.centerY), beginElement.w, beginElement.h);
									routeList[i].setXY1(starp.X, starp.Y);
									endp = GetPointAtRectangle(new Point(currentElement.centerX, currentElement.centerY), new Point(beginElement.centerX, beginElement.centerY), currentElement.w, currentElement.h);
									routeList[i].setXY2(endp.X, endp.Y);
								}
							} else { //双向路由的情况
								var gbpoints = GoBackPoint(new Point(beginElement.centerX, beginElement.centerY), new Point(endElement.centerX, endElement.centerY), beginElement.dragRadius, routeList[i].routeType, beginElement.w, beginElement.h);
								routeList[i].setXY1(gbpoints[0].X, gbpoints[0].Y);
								routeList[i].setXY2(gbpoints[1].X, gbpoints[1].Y);
							}
						}
					}
				}
				reDrawDesigner();
			}
		}

		isDown = false;
		isDrag = false;
	}
	var clickTimeFunc = null;

	function OnClick(evt) {
		//info("鼠标点击事件");
		if(isClick) {
			//如果是点击事件
			contextTmp.clearRect(0, 0, canvasTmp.width, canvasTmp.height);
			var mouseX = getMousePos(canvas, evt).x;
			var mouseY = getMousePos(canvas, evt).y;
			var mousePoint = new Point(mouseX, mouseY);
			// 取消上次延时未执行的方法
			if(clickTimeFunc != null)
				clearTimeout(clickTimeFunc);
			clickTimeFunc = setTimeout(function() {
				var hasEle = false;
				//判断是否点中路由
				for(var i = 0; i < routeList.length; i++) {
					var sp = new Point(routeList[i].x1, routeList[i].y1);
					var ep = new Point(routeList[i].x2, routeList[i].y2);
					if(IsPtInLine(mousePoint, sp, ep, 15)) {
						hasEle = true;
						//选中路由
						currentElement = routeList[i];
						routeList[i].setChecked(true);

						//info("选中路由节点" + currentElement.id);
						//info("选中路由开始" + currentElement.beginID);
						//info("选中路由结束" + currentElement.endID);

						//请求服务器
						if($("#wfEdit").length > 0) {
							ajaxHtml("selectRoute", { nodeID: currentElement.id }, function(data) {
								$("#wfEdit").html(data);
								setDialogCSS();
							});
						}

					} else if(routeList[i].checked) {
						routeList[i].setChecked(false);
					}
				}
				//判断是否点中活动节点
				if(!hasEle) {
					for(var i = 0; i < elementList.length; i++) {
						var tmpPoints = [];
						var point1 = new Point(elementList[i].x, elementList[i].y);
						tmpPoints.push(point1);
						var point2 = new Point(elementList[i].x + elementList[i].w, elementList[i].y);
						tmpPoints.push(point2);
						var point3 = new Point(elementList[i].x + elementList[i].w, elementList[i].y + elementList[i].h);
						tmpPoints.push(point3);
						var point4 = new Point(elementList[i].x, elementList[i].y + elementList[i].h);
						tmpPoints.push(point4);
						if(IsPtInPolygon(mousePoint, tmpPoints)) {
							hasEle = true;
							//选中中间节点
							currentElement = elementList[i];
							//info("选中中间节点" + currentElement.id);
							var selectTmp = new RectSelect(elementList[i].x, elementList[i].y);
							selectTmp.draw();
							break;
						}
					}
				}
				if(!hasEle)
					currentElement = null;
			}, 100);
		}
	}

	function OnDblClick(evt) {
		//info("28");
		// 取消上次延时未执行的方法
		if(clickTimeFunc != null)
			clearTimeout(clickTimeFunc);

		var selectEle = null;
		var mouseX = getMousePos(canvas, evt).x;
		var mouseY = getMousePos(canvas, evt).y;
		var mousePoint = new Point(mouseX, mouseY);
		var hasEle = false;
		//判断是否点中路由
		for(var i = 0; i < routeList.length; i++) {
			var sp = new Point(routeList[i].x1, routeList[i].y1);
			var ep = new Point(routeList[i].x2, routeList[i].y2);
			if(IsPtInLine(mousePoint, sp, ep, 15)) {
				hasEle = true;
				//选中节点
				selectEle = routeList[i];
				break;
			}
		}
		//判断是否点中活动节点
		if(!hasEle) {
			for(var i = 0; i < elementList.length; i++) {
				var tmpPoints = [];
				var point1 = new Point(elementList[i].x, elementList[i].y);
				tmpPoints.push(point1);
				var point2 = new Point(elementList[i].x + elementList[i].w, elementList[i].y);
				tmpPoints.push(point2);
				var point3 = new Point(elementList[i].x + elementList[i].w, elementList[i].y + elementList[i].h);
				tmpPoints.push(point3);
				var point4 = new Point(elementList[i].x, elementList[i].y + elementList[i].h);
				tmpPoints.push(point4);
				if(IsPtInPolygon(mousePoint, tmpPoints)) {
					hasEle = true;
					//选中节点
					selectEle = elementList[i];
					break;
				}
			}
		}
		if(!hasEle)
			selectEle = null;

		//将当前选中的对象，生成json数据，然后传递给指定的外部函数
		if(options.dbmousefunction != "") {
			var fn = window[options.dbmousefunction];
			if(selectEle != null) {
				if(selectEle.x1)
					fn("r," + selectEle.id);
				else
					fn("a," + selectEle.id);
			} else
				fn();
		}
	}

	//插件扩展方法draw
	//==================
	// 供外部调用的方法
	//==================
	/* opts      属性值：
	rowID:1                 审批流节点行号
	mouseevent:true         是否响应鼠标事件
	dbmousefunction: ""     响应鼠标双击事件的函数
	jsondata: null          工作流的json数据
	curactives: null        需要高亮显示的活动节点ID数组
	snradius:25             起始和终止节点的半径
	activewidth:100         活动节点的宽
	activeheight:50         活动节点的高
	linewidth:3             路由线条的宽度
	bstyle:"#00ff21"        起始节点颜色
	estyle:"#333"           终结点颜色
	astyle:"#0094ff"        活动节点颜色
	mstyle:"#666"           拖拽点的颜色
	rstyle:"#22c339"        路由线的颜色
	atstyle:"#fff"          活动节点文字颜色
	rtstyle:"#ff0000"       路由节点文字颜色
	ttstyle:"9pt Calibri"   文字大小及字体
	sstyle:"#ff6a00"        选中时的颜色
	*/
	/* jsondata 的数据结构
	jsondata {
	    begin; 起始点的json数据
	    activeArray; 活动节点的json数据数组
	    routeArray; 路由的json数据数组
	    end; 终结点的json数据
	}
	*/
	$.fn.extend({
		"draw": function(opts) {
			//info("插件开始执行");
			options = $.extend({}, defaultOptions, opts);
			//创建画板
			if(canvas == null) {
				$(this).append("<canvas id=\"wf-designerTmp\" width=\"" + $(this).width() + "\" height=\"" + $(this).height() + "\" style=\"border: 1px solid #ccc;z-index: 999;position:absolute;top:0;left:0;\"></canvas><canvas id=\"wf-designer\" width=\"" + $(this).width() + "\" height=\"" + $(this).height() + "\" style=\"border: 1px solid #ccc;z-index: 1000;position:absolute;top:0;left:0;\"></canvas>");
				//获取到舞台
				canvas = document.getElementById("wf-designer");
				//舞台2d绘图接口
				context = canvas.getContext("2d");
				//获得预览舞台
				canvasTmp = document.getElementById("wf-designerTmp");
				//预览舞台2d绘图接口
				contextTmp = canvasTmp.getContext("2d");
			}

			//清除画布
			context.clearRect(0, 0, canvas.width, canvas.height);
			//清空活动节点序列
			elementList = [];
			//清空路由序列
			routeList = [];

			//绑定画布的鼠标事件
			canvas.removeEventListener("mousedown", OnMouseDown, false);
			canvas.removeEventListener("mousemove", OnMouseMove, false);
			canvas.removeEventListener("mouseup", OnMouseUp, false);
			canvas.removeEventListener("click", OnClick, false);
			canvas.removeEventListener("dblclick", OnDblClick, false);
			if(options.mouseevent) {
				canvas.addEventListener("mousedown", OnMouseDown, false);
				canvas.addEventListener("mousemove", OnMouseMove, false);
				canvas.addEventListener("mouseup", OnMouseUp, false);
				canvas.addEventListener("click", OnClick, false);
				canvas.addEventListener("dblclick", OnDblClick, false);
			}
			if(options.jsondata != null) {
				//info("根据节点信息创建画布");
				//根据json数据，创建起始点、终结点、活动节点、路由
				var sbegin = JSON.parse(options.jsondata.begin);
				begin = new BeginPoint(sbegin.x, sbegin.y, sbegin.radius, sbegin.id);
				var send = JSON.parse(options.jsondata.end);
				end = new EndPoint(send.x, send.y, send.radius, send.id);
				for(var i = 0; i < options.jsondata.activeArray.length; i++) {
					var ele = JSON.parse(options.jsondata.activeArray[i]);
					var rct = new Rect(ele.x, ele.y, ele.id, ele.name);
					elementList.push(rct);
				}
				for(var i = 0; i < options.jsondata.routeArray.length; i++) {
					var rou = JSON.parse(options.jsondata.routeArray[i]);
					var rt = new Arrow(rou.x1, rou.y1, rou.x2, rou.y2, rou.beginID, rou.endID, rou.id, rou.routeType, rou.name);
					routeList.push(rt);
				}

				//开始绘制
				begin.draw();
				end.draw();
				for(var i = 0; i < elementList.length; i++) {
					//如果crtActives不为空，则需要判断对应的节点，并设置高亮 setHightShow()
					if(options.curactives != null)
						for(var n = 0; n < options.curactives.length; n++) {
							if(elementList[i].id == options.curactives[n]) {
								elementList[i].setHightShow();
								break;
							}
						}
					elementList[i].draw();
				}
				for(var i = 0; i < routeList.length; i++) {
					routeList[i].draw();
				}
			} else {
				//info("创建初始画布");
				var beginID = guid();
				begin = new BeginPoint(options.snradius, options.snradius, options.snradius, beginID);
				begin.draw();
				//info("创建开始:" + beginID);

				var endID = guid();
				end = new EndPoint(options.snradius, canvas.height - options.snradius, options.snradius, endID);
				end.draw();
				//info("创建结束:" + endID);

				//提交服务器
				ajaxPost("createStartAndEnd", { rowID: options.rowID, startID: beginID, endID: endID }, function(data) {
					showJsonResult(data);
				});

			}
			return this;
		},
		"buildJson": function() {
			//info("30");
			var wfobj = function() {
				this.begin = JSON.stringify(begin);
				this.activeArray = null;
				var actarray = [];
				for(var i = 0; i < elementList.length; i++) {
					actarray.push(JSON.stringify(elementList[i]));
				}
				this.activeArray = actarray;

				this.routeArray = null;
				var rouarray = []
				for(var i = 0; i < routeList.length; i++) {
					rouarray.push(JSON.stringify(routeList[i]));
				}
				this.routeArray = rouarray;
				this.end = JSON.stringify(end);
			}
			var wfComplete = checkWF();
			if(wfComplete == "")
				return(new wfobj());
			else
				alert(wfComplete);
		},
		"getJson": function() {
			//info("30");
			var wfobj = function() {
				this.begin = JSON.stringify(begin);
				this.activeArray = null;
				var actarray = [];
				for(var i = 0; i < elementList.length; i++) {
					actarray.push(JSON.stringify(elementList[i]));
				}
				this.activeArray = actarray;

				this.routeArray = null;
				var rouarray = []
				for(var i = 0; i < routeList.length; i++) {
					rouarray.push(JSON.stringify(routeList[i]));
				}
				this.routeArray = rouarray;
				this.end = JSON.stringify(end);
			}
			return(new wfobj());
		},
		//创建新节点
		"createActive": function() {
			var id = guid();
			var rect = new Rect(100, 10, id);
			rect.draw();
			elementList.push(rect);
			//info("创建新节点" + id);

			//提交服务器
			ajaxPost("createNode", { rowID: options.rowID, guidID: id }, function(data) {
				showJsonResult(data);
			});
		},
		//删除节点
		"deleteElement": function(id) {
			var currentid = "";
			if(id)
				currentid = id.toLowerCase();
			else if(currentElement != null)
				currentid = currentElement.id.toLowerCase();
			else
				return false;
			//info("删除结点" + currentid);
			//先检查活动节点
			var isdel = false;
			var type = "";
			for(var i = elementList.length - 1; i >= 0; i--) {
				if(elementList[i].id.toLowerCase() == currentid) {
					//删除与此活动节点关联的路由
					for(var n = routeList.length - 1; n >= 0; n--) {
						if(routeList[n].beginID.toLowerCase() == currentid || routeList[n].endID.toLowerCase() == currentid)
							routeList.splice(n, 1);
					}
					elementList.splice(i, 1);
					isdel = true;
					type = "active";
					//info("删除结点" + currentid);
					break;
				}
			}
			//再检查路由节点
			if(!isdel) {
				for(var i = routeList.length - 1; i >= 0; i--) {
					if(routeList[i].id.toLowerCase() == currentid) {
						//info("删除线条开始节点：" + routeList[i].beginID);
						//info("删除线条结束节点:" + routeList[i].endID);
						routeList.splice(i, 1);
						isdel = true;
						type = "route";
						break;
					}
				}
			}
			if(isdel) {
				//info("删除成功");
				//提交服务器
				ajaxPost("dropElement", { rowID: options.rowID, guidID: currentid, type: type }, function(data) {
					showJsonResult(data);
				});

				contextTmp.clearRect(0, 0, canvasTmp.width, canvasTmp.height);
				reDrawDesigner();
			}
			return(isdel);
		},
		"setName": function(etype, id, name) {
			//info("33");
			if(etype == "a") {
				for(var i = 0; i < elementList.length; i++) {
					if(elementList[i].id == id) {
						elementList[i].setName(name);
						break;
					}
				}
			} else if(etype == "r") {
				for(var i = 0; i < routeList.length; i++) {
					if(routeList[i].id == id) {
						routeList[i].setName(name);
						break;
					}
				}
			}
			reDrawDesigner();
		}
	});
})(jQuery);;