package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;
import src.engine.gui.Formspec.FormspecStyle;

class FormspecTextArea extends FormspecElement {
	public function toFormspec(name: String): String {
		throw new haxe.exceptions.NotImplementedException();
	}
}

class FormspecTextAreaStyle extends FormspecStyle {
	public function toFormspec(name: String, windowScale: Float): String {
		throw new haxe.exceptions.NotImplementedException();
	}
}
