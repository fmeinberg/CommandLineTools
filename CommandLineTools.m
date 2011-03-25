BeginPackage["CommandLineTools`"]

CommandLineString::usage="";

Begin["Private`"];

EscapeCharacter=
	Alternatives["&"];

EscapeCommandLineString[string_]:=
	StringReplace[string, w:(WhitespaceCharacter|EscapeCharacter) :> StringJoin["\\",w]]

ToOptionString[optionRule_Rule] :=
    StringJoin["-", First@optionRule, " ", Last@optionRule]

CommandLineString[command_, args_List, opts:OptionsPattern[]]:=
	StringJoin@Flatten@{
		command,
		" ",
		Riffle[ToOptionString/@Flatten[{opts}]," "],
		" ",
		Riffle[EscapeCommandLineString/@args," "]}

CommandLineString[command_, args__String, opts:OptionsPattern[]]:=
	CommandLineString[command, {args}, opts]

CommandLineString[command_, opts:OptionsPattern[]]:=
	CommandLineString[command, {}, opts]

End[];
EndPackage[];