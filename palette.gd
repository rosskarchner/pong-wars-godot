extends Node
class_name Palette

enum Phase {DAY,NIGHT}

const ArcticPowder:=Color("#F1F6F4")
const MysticMint:= Color("#D9E8E3")
const Forsythia:= Color("#FFC801")
const DeepSaffron:= Color("#FF9932")
const NocturnalExpedition:= Color("#114C5A")
const OceanicNoir:= Color("#172B36")



const DAY_COLOR = MysticMint;
const DAY_BALL_COLOR = NocturnalExpedition;
const NIGHT_COLOR = NocturnalExpedition;
const NIGHT_BALL_COLOR = MysticMint;

const BALL_COLOR_LOOKUP:= {
	Phase.DAY: DAY_BALL_COLOR,
	Phase.NIGHT: NIGHT_BALL_COLOR
}

const BLOCK_COLOR_LOOKUP:={
	Phase.DAY: DAY_COLOR,
	Phase.NIGHT: NIGHT_COLOR	
}
