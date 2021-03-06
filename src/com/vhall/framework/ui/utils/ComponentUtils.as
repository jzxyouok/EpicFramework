package com.vhall.framework.ui.utils
{
	import com.vhall.framework.ui.controls.UIComponent;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;

	/**
	 *	技术控件工具类
	 * @author Sol
	 *
	 */
	public class ComponentUtils
	{
		/**
		 *	创建一个可交互的可显示对象
		 */
		public static function genInteractiveRect(w:Number, h:Number, p:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, fillColor:uint = 0xC0C0C0, fillAlpha:Number = 1, borderThickness:Number = NaN, borderColor:uint = 0, borderAlpha:Number = 1, ellipseWidth:Number = 0, ellipseHeight:Number = 0):UIComponent
		{
			var comp:UIComponent = new UIComponent(p, xpos, ypos);
			var temp:Number = isNaN(borderThickness) ? 0 : borderThickness / 2;
			with (comp)
			{
				if (!isNaN(borderThickness))
				{
					graphics.lineStyle(borderThickness, borderColor, borderAlpha, true);
				}
				graphics.beginFill(fillColor, fillAlpha);
				graphics.drawRoundRect(0, 0, w - 2 * temp, h - 2 * temp, ellipseWidth, ellipseHeight);
				graphics.endFill();
			}
			return comp;
		}

		/**
		 *	创建一个可交互的圆
		 * @param r	半径
		 * @param p	父容器
		 * @param xpos 横坐标
		 * @param ypos 纵坐标
		 * @param fillColor 填充颜色
		 * @param fillAlpha	填充颜色的透明度
		 * @param borderThickness	外边的半径
		 * @param borderColor	外边的颜色
		 * @param borderAplha	外边的透明度
		 * @return 一个可交互的圆
		 *
		 */
		public static function genInteractiveCircle(r:Number, p:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, fillColor:uint = 0, fillAlpha:Number = 1, borderThickness:Number = NaN, borderColor:uint = 0, borderAplha:Number = 1):UIComponent
		{
			var comp:UIComponent = new UIComponent(p, xpos, ypos);
			var temp:Number = isNaN(borderThickness) ? 0 : borderThickness / 2;
			with (comp)
			{
				if (!isNaN(borderThickness))
				{
					graphics.lineStyle(borderThickness, borderColor, borderAplha, true);
				}

				graphics.beginFill(fillColor, fillAlpha);
				graphics.drawCircle(r, r, r - temp);
				graphics.endFill();
			}

			return comp;
		}

		public static function getDisplayBmd(target:DisplayObject):BitmapData
		{
			var bmd:BitmapData = new BitmapData(target.width, target.height, true, 0xFFFFFF);
			bmd.draw(target);
			return bmd;
		}
	}
}
