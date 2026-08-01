package src.engine.gui;

import src.engine.gui.Formspec.FormspecElement;
import src.engine.gui.Formspec.FormspecStyle;

class FormspecButton extends FormspecElement {
	public function toFormspec(name: String): String {
		throw new haxe.exceptions.NotImplementedException();
	}
}

class FormspecButtonStyle extends FormspecStyle {
	public function toFormspec(name: String, windowScale: Float): String {
		throw new haxe.exceptions.NotImplementedException();
	}
}
