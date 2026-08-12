package src.engine.gui;

import src.engine.gui.Gui.GuiElement;

/*
This is fucking horrible.
For customization, as of 12/8/26 there is no:
- font selection
- font color
- font size
- checkbox button texture

So before anyone complains about this implementation looking bland they can read this and go fucking
look at the fucking documentation. No custom fucking checkbox will be implemented.
This should be out of the box customizable and no fucking additional hackjobs should 
need to be implemented for a fucking checkbox.
*/
class CheckBox extends GuiElement {
	public function toFormspec(name: String): String {
		throw new haxe.exceptions.NotImplementedException();
	}
}
