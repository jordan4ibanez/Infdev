package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;

class FormspecList extends FormspecElement {
	public function toFormspec(name: String): String {
		return 'list[<inventory location>;<list name>;<X>,<Y>;<W>,<H>;<starting item index>]';
	}
}
