package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;

class FormspecTabHeader extends FormspecElement {
	public function toFormspec(name: String): String {
		// return 'tabheader[<X>,<Y>;<W>,<H>;<name>;<caption 1>,<caption 2>,...,<caption n>;<current_tab>;<transparent>;<draw_border>]';
        return 'tabheader[0,0;2,1;navigation;this,is,a,test;1;false;true]';
	}
}
