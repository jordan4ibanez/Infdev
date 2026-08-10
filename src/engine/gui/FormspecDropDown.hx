package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;

class FormspecDropDown extends FormspecElement {
	public function new() {}

	public function toFormspec(name: String): String {
		return 'dropdown[<X>,<Y>;<W>;<name>;<item 1>,<item 2>, ...,<item n>;<selected idx>;<index event>]';
	}
}
