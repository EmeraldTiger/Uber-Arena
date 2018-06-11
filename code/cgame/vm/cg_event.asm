bss
align 1
LABELV $71
skip 64
export CG_PlaceString
code
proc CG_PlaceString 12 20
file "../cg_event.c"
line 40
;1:/*
;2:===========================================================================
;3:Copyright (C) 1999-2005 Id Software, Inc.
;4:
;5:This file is part of Quake III Arena source code.
;6:
;7:Quake III Arena source code is free software; you can redistribute it
;8:and/or modify it under the terms of the GNU General Public License as
;9:published by the Free Software Foundation; either version 2 of the License,
;10:or (at your option) any later version.
;11:
;12:Quake III Arena source code is distributed in the hope that it will be
;13:useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;14:MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;15:GNU General Public License for more details.
;16:
;17:You should have received a copy of the GNU General Public License
;18:along with Foobar; if not, write to the Free Software
;19:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;20:===========================================================================
;21:*/
;22://
;23:// cg_event.c -- handle entity events at snapshot or playerstate transitions
;24:
;25:#include "cg_local.h"
;26:
;27:// for the voice chats
;28:#ifdef MISSIONPACK // bk001205
;29:#include "../../ui/menudef.h"
;30:#endif
;31://==========================================================================
;32:
;33:/*
;34:===================
;35:CG_PlaceString
;36:
;37:Also called by scoreboard drawing
;38:===================
;39:*/
;40:const char	*CG_PlaceString( int rank ) {
line 44
;41:	static char	str[64];
;42:	char	*s, *t;
;43:
;44:	if ( rank & RANK_TIED_FLAG ) {
ADDRFP4 0
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $72
line 45
;45:		rank &= ~RANK_TIED_FLAG;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 46
;46:		t = "Tied for ";
ADDRLP4 4
ADDRGP4 $74
ASGNP4
line 47
;47:	} else {
ADDRGP4 $73
JUMPV
LABELV $72
line 48
;48:		t = "";
ADDRLP4 4
ADDRGP4 $75
ASGNP4
line 49
;49:	}
LABELV $73
line 51
;50:
;51:	if ( rank == 1 ) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $76
line 52
;52:		s = S_COLOR_BLUE "1st" S_COLOR_WHITE;		// draw in blue
ADDRLP4 0
ADDRGP4 $78
ASGNP4
line 53
;53:	} else if ( rank == 2 ) {
ADDRGP4 $77
JUMPV
LABELV $76
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $79
line 54
;54:		s = S_COLOR_RED "2nd" S_COLOR_WHITE;		// draw in red
ADDRLP4 0
ADDRGP4 $81
ASGNP4
line 55
;55:	} else if ( rank == 3 ) {
ADDRGP4 $80
JUMPV
LABELV $79
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $82
line 56
;56:		s = S_COLOR_YELLOW "3rd" S_COLOR_WHITE;		// draw in yellow
ADDRLP4 0
ADDRGP4 $84
ASGNP4
line 57
;57:	} else if ( rank == 11 ) {
ADDRGP4 $83
JUMPV
LABELV $82
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $85
line 58
;58:		s = "11th";
ADDRLP4 0
ADDRGP4 $87
ASGNP4
line 59
;59:	} else if ( rank == 12 ) {
ADDRGP4 $86
JUMPV
LABELV $85
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $88
line 60
;60:		s = "12th";
ADDRLP4 0
ADDRGP4 $90
ASGNP4
line 61
;61:	} else if ( rank == 13 ) {
ADDRGP4 $89
JUMPV
LABELV $88
ADDRFP4 0
INDIRI4
CNSTI4 13
NEI4 $91
line 62
;62:		s = "13th";
ADDRLP4 0
ADDRGP4 $93
ASGNP4
line 63
;63:	} else if ( rank % 10 == 1 ) {
ADDRGP4 $92
JUMPV
LABELV $91
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $94
line 64
;64:		s = va("%ist", rank);
ADDRGP4 $96
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 65
;65:	} else if ( rank % 10 == 2 ) {
ADDRGP4 $95
JUMPV
LABELV $94
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
NEI4 $97
line 66
;66:		s = va("%ind", rank);
ADDRGP4 $99
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 67
;67:	} else if ( rank % 10 == 3 ) {
ADDRGP4 $98
JUMPV
LABELV $97
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 3
NEI4 $100
line 68
;68:		s = va("%ird", rank);
ADDRGP4 $102
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 69
;69:	} else {
ADDRGP4 $101
JUMPV
LABELV $100
line 70
;70:		s = va("%ith", rank);
ADDRGP4 $103
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 71
;71:	}
LABELV $101
LABELV $98
LABELV $95
LABELV $92
LABELV $89
LABELV $86
LABELV $83
LABELV $80
LABELV $77
line 73
;72:
;73:	Com_sprintf( str, sizeof( str ), "%s%s", t, s );
ADDRGP4 $71
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $104
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 74
;74:	return str;
ADDRGP4 $71
RETP4
LABELV $70
endproc CG_PlaceString 12 20
proc CG_Obituary 132 20
line 82
;75:}
;76:
;77:/*
;78:=============
;79:CG_Obituary
;80:=============
;81:*/
;82:static void CG_Obituary( entityState_t *ent ) {
line 94
;83:	int			mod;
;84:	int			target, attacker;
;85:	char		*message;
;86:	char		*message2;
;87:	const char	*targetInfo;
;88:	const char	*attackerInfo;
;89:	char		targetName[32];
;90:	char		attackerName[32];
;91:	gender_t	gender;
;92:	clientInfo_t	*ci;
;93:
;94:	target = ent->otherEntityNum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 95
;95:	attacker = ent->otherEntityNum2;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 96
;96:	mod = ent->eventParm;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 98
;97:
;98:	if ( target < 0 || target >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $108
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $106
LABELV $108
line 99
;99:		CG_Error( "CG_Obituary: target out of range" );
ADDRGP4 $109
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 100
;100:	}
LABELV $106
line 101
;101:	ci = &cgs.clientinfo[target];
ADDRLP4 92
CNSTI4 1708
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 103
;102:
;103:	if ( attacker < 0 || attacker >= MAX_CLIENTS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $113
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $111
LABELV $113
line 104
;104:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 105
;105:		attackerInfo = NULL;
ADDRLP4 52
CNSTP4 0
ASGNP4
line 106
;106:	} else {
ADDRGP4 $112
JUMPV
LABELV $111
line 107
;107:		attackerInfo = CG_ConfigString( CS_PLAYERS + attacker );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 108
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 108
INDIRP4
ASGNP4
line 108
;108:	}
LABELV $112
line 110
;109:
;110:	targetInfo = CG_ConfigString( CS_PLAYERS + target );
ADDRLP4 4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 108
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 108
INDIRP4
ASGNP4
line 111
;111:	if ( !targetInfo ) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $114
line 112
;112:		return;
ADDRGP4 $105
JUMPV
LABELV $114
line 114
;113:	}
;114:	Q_strncpyz( targetName, Info_ValueForKey( targetInfo, "n" ), sizeof(targetName) - 2);
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 $116
ARGP4
ADDRLP4 112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 115
;115:	strcat( targetName, S_COLOR_WHITE );
ADDRLP4 8
ARGP4
ADDRGP4 $117
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 117
;116:
;117:	message2 = "";
ADDRLP4 88
ADDRGP4 $75
ASGNP4
line 121
;118:
;119:	// check for single client messages
;120:
;121:	switch( mod ) {
ADDRLP4 44
INDIRI4
CNSTI4 14
LTI4 $118
ADDRLP4 44
INDIRI4
CNSTI4 22
GTI4 $118
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $136-56
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $136
address $126
address $128
address $130
address $124
address $118
address $122
address $120
address $132
address $134
code
LABELV $120
line 123
;122:	case MOD_SUICIDE:
;123:		message = "suicides";
ADDRLP4 40
ADDRGP4 $121
ASGNP4
line 124
;124:		break;
ADDRGP4 $119
JUMPV
LABELV $122
line 126
;125:	case MOD_FALLING:
;126:		message = "cratered";
ADDRLP4 40
ADDRGP4 $123
ASGNP4
line 127
;127:		break;
ADDRGP4 $119
JUMPV
LABELV $124
line 129
;128:	case MOD_CRUSH:
;129:		message = "was squished";
ADDRLP4 40
ADDRGP4 $125
ASGNP4
line 130
;130:		break;
ADDRGP4 $119
JUMPV
LABELV $126
line 132
;131:	case MOD_WATER:
;132:		message = "sank like a rock";
ADDRLP4 40
ADDRGP4 $127
ASGNP4
line 133
;133:		break;
ADDRGP4 $119
JUMPV
LABELV $128
line 135
;134:	case MOD_SLIME:
;135:		message = "melted";
ADDRLP4 40
ADDRGP4 $129
ASGNP4
line 136
;136:		break;
ADDRGP4 $119
JUMPV
LABELV $130
line 138
;137:	case MOD_LAVA:
;138:		message = "does a back flip into the lava";
ADDRLP4 40
ADDRGP4 $131
ASGNP4
line 139
;139:		break;
ADDRGP4 $119
JUMPV
LABELV $132
line 141
;140:	case MOD_TARGET_LASER:
;141:		message = "saw the light";
ADDRLP4 40
ADDRGP4 $133
ASGNP4
line 142
;142:		break;
ADDRGP4 $119
JUMPV
LABELV $134
line 144
;143:	case MOD_TRIGGER_HURT:
;144:		message = "was in the wrong place";
ADDRLP4 40
ADDRGP4 $135
ASGNP4
line 145
;145:		break;
ADDRGP4 $119
JUMPV
LABELV $118
line 147
;146:	default:
;147:		message = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 148
;148:		break;
LABELV $119
line 151
;149:	}
;150:
;151:	if (attacker == target) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $138
line 152
;152:		gender = ci->gender;
ADDRLP4 96
ADDRLP4 92
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 153
;153:		switch (mod) {
ADDRLP4 124
CNSTI4 5
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 124
INDIRI4
EQI4 $142
ADDRLP4 44
INDIRI4
CNSTI4 7
EQI4 $150
ADDRLP4 44
INDIRI4
CNSTI4 9
EQI4 $158
ADDRLP4 44
INDIRI4
ADDRLP4 124
INDIRI4
LTI4 $140
LABELV $175
ADDRLP4 44
INDIRI4
CNSTI4 13
EQI4 $166
ADDRGP4 $140
JUMPV
LABELV $142
line 160
;154:#ifdef MISSIONPACK
;155:		case MOD_KAMIKAZE:
;156:			message = "goes out with a bang";
;157:			break;
;158:#endif
;159:		case MOD_GRENADE_SPLASH:
;160:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $143
line 161
;161:				message = "tripped on her own grenade";
ADDRLP4 40
ADDRGP4 $145
ASGNP4
ADDRGP4 $141
JUMPV
LABELV $143
line 162
;162:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $146
line 163
;163:				message = "tripped on its own grenade";
ADDRLP4 40
ADDRGP4 $148
ASGNP4
ADDRGP4 $141
JUMPV
LABELV $146
line 165
;164:			else
;165:				message = "tripped on his own grenade";
ADDRLP4 40
ADDRGP4 $149
ASGNP4
line 166
;166:			break;
ADDRGP4 $141
JUMPV
LABELV $150
line 168
;167:		case MOD_ROCKET_SPLASH:
;168:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $151
line 169
;169:				message = "blew herself up";
ADDRLP4 40
ADDRGP4 $153
ASGNP4
ADDRGP4 $141
JUMPV
LABELV $151
line 170
;170:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $154
line 171
;171:				message = "blew itself up";
ADDRLP4 40
ADDRGP4 $156
ASGNP4
ADDRGP4 $141
JUMPV
LABELV $154
line 173
;172:			else
;173:				message = "blew himself up";
ADDRLP4 40
ADDRGP4 $157
ASGNP4
line 174
;174:			break;
ADDRGP4 $141
JUMPV
LABELV $158
line 176
;175:		case MOD_PLASMA_SPLASH:
;176:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $159
line 177
;177:				message = "melted herself";
ADDRLP4 40
ADDRGP4 $161
ASGNP4
ADDRGP4 $141
JUMPV
LABELV $159
line 178
;178:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $162
line 179
;179:				message = "melted itself";
ADDRLP4 40
ADDRGP4 $164
ASGNP4
ADDRGP4 $141
JUMPV
LABELV $162
line 181
;180:			else
;181:				message = "melted himself";
ADDRLP4 40
ADDRGP4 $165
ASGNP4
line 182
;182:			break;
ADDRGP4 $141
JUMPV
LABELV $166
line 184
;183:		case MOD_BFG_SPLASH:
;184:			message = "should have used a smaller gun";
ADDRLP4 40
ADDRGP4 $167
ASGNP4
line 185
;185:			break;
ADDRGP4 $141
JUMPV
LABELV $140
line 198
;186:#ifdef MISSIONPACK
;187:		case MOD_PROXIMITY_MINE:
;188:			if( gender == GENDER_FEMALE ) {
;189:				message = "found her prox mine";
;190:			} else if ( gender == GENDER_NEUTER ) {
;191:				message = "found it's prox mine";
;192:			} else {
;193:				message = "found his prox mine";
;194:			}
;195:			break;
;196:#endif
;197:		default:
;198:			if ( gender == GENDER_FEMALE )
ADDRLP4 96
INDIRI4
CNSTI4 1
NEI4 $168
line 199
;199:				message = "killed herself";
ADDRLP4 40
ADDRGP4 $170
ASGNP4
ADDRGP4 $141
JUMPV
LABELV $168
line 200
;200:			else if ( gender == GENDER_NEUTER )
ADDRLP4 96
INDIRI4
CNSTI4 2
NEI4 $171
line 201
;201:				message = "killed itself";
ADDRLP4 40
ADDRGP4 $173
ASGNP4
ADDRGP4 $141
JUMPV
LABELV $171
line 203
;202:			else
;203:				message = "killed himself";
ADDRLP4 40
ADDRGP4 $174
ASGNP4
line 204
;204:			break;
LABELV $141
line 206
;205:		}
;206:	}
LABELV $138
line 208
;207:
;208:	if (message) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $176
line 209
;209:		CG_Printf( "%s %s.\n", targetName, message);
ADDRGP4 $178
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 210
;210:		return;
ADDRGP4 $105
JUMPV
LABELV $176
line 214
;211:	}
;212:
;213:	// check for kill messages from the current clientNum
;214:	if ( attacker == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $179
line 217
;215:		char	*s;
;216:
;217:		if ( cgs.gametype < GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $182
line 218
;218:			s = va("You fragged %s\n%s place with %i", targetName, 
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 124
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $185
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 120
ADDRLP4 128
INDIRP4
ASGNP4
line 221
;219:				CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),
;220:				cg.snap->ps.persistant[PERS_SCORE] );
;221:		} else {
ADDRGP4 $183
JUMPV
LABELV $182
line 222
;222:			s = va("You fragged %s", targetName );
ADDRGP4 $188
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 124
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 120
ADDRLP4 124
INDIRP4
ASGNP4
line 223
;223:		}
LABELV $183
line 229
;224:#ifdef MISSIONPACK
;225:		if (!(cg_singlePlayerActive.integer && cg_cameraOrbit.integer)) {
;226:			CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
;227:		} 
;228:#else
;229:		CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRLP4 120
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 233
;230:#endif
;231:
;232:		// print the text message as well
;233:	}
LABELV $179
line 236
;234:
;235:	// check for double client messages
;236:	if ( !attackerInfo ) {
ADDRLP4 52
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $189
line 237
;237:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 238
;238:		strcpy( attackerName, "noname" );
ADDRLP4 56
ARGP4
ADDRGP4 $191
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 239
;239:	} else {
ADDRGP4 $190
JUMPV
LABELV $189
line 240
;240:		Q_strncpyz( attackerName, Info_ValueForKey( attackerInfo, "n" ), sizeof(attackerName) - 2);
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 $116
ARGP4
ADDRLP4 120
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
ARGP4
ADDRLP4 120
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 241
;241:		strcat( attackerName, S_COLOR_WHITE );
ADDRLP4 56
ARGP4
ADDRGP4 $117
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 243
;242:		// check for kill messages about the current clientNum
;243:		if ( target == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $192
line 244
;244:			Q_strncpyz( cg.killerName, attackerName, sizeof( cg.killerName ) );
ADDRGP4 cg+118448
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 245
;245:		}
LABELV $192
line 246
;246:	}
LABELV $190
line 248
;247:
;248:	if ( attacker != ENTITYNUM_WORLD ) {
ADDRLP4 0
INDIRI4
CNSTI4 1022
EQI4 $197
line 249
;249:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 1
LTI4 $199
ADDRLP4 44
INDIRI4
CNSTI4 38
GTI4 $199
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $257-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $257
address $207
address $203
address $205
address $209
address $212
address $215
address $217
address $219
address $222
address $223
address $225
address $227
address $227
address $199
address $199
address $199
address $199
address $253
address $199
address $199
address $199
address $199
address $230
address $233
address $234
address $237
address $238
address $241
address $242
address $244
address $247
address $199
address $248
address $250
address $199
address $199
address $251
address $201
code
LABELV $201
line 251
;250:		case MOD_GRAPPLE:
;251:			message = "was caught by";
ADDRLP4 40
ADDRGP4 $202
ASGNP4
line 252
;252:			break;
ADDRGP4 $200
JUMPV
LABELV $203
line 254
;253:		case MOD_GAUNTLET:
;254:			message = "was pummeled by";
ADDRLP4 40
ADDRGP4 $204
ASGNP4
line 255
;255:			break;
ADDRGP4 $200
JUMPV
LABELV $205
line 257
;256:		case MOD_MACHINEGUN:
;257:			message = "was machinegunned by";
ADDRLP4 40
ADDRGP4 $206
ASGNP4
line 258
;258:			break;
ADDRGP4 $200
JUMPV
LABELV $207
line 260
;259:		case MOD_SHOTGUN:
;260:			message = "was gunned down by";
ADDRLP4 40
ADDRGP4 $208
ASGNP4
line 261
;261:			break;
ADDRGP4 $200
JUMPV
LABELV $209
line 263
;262:		case MOD_GRENADE:
;263:			message = "ate";
ADDRLP4 40
ADDRGP4 $210
ASGNP4
line 264
;264:			message2 = "'s grenade";
ADDRLP4 88
ADDRGP4 $211
ASGNP4
line 265
;265:			break;
ADDRGP4 $200
JUMPV
LABELV $212
line 267
;266:		case MOD_GRENADE_SPLASH:
;267:			message = "was shredded by";
ADDRLP4 40
ADDRGP4 $213
ASGNP4
line 268
;268:			message2 = "'s shrapnel";
ADDRLP4 88
ADDRGP4 $214
ASGNP4
line 269
;269:			break;
ADDRGP4 $200
JUMPV
LABELV $215
line 271
;270:		case MOD_ROCKET:
;271:			message = "ate";
ADDRLP4 40
ADDRGP4 $210
ASGNP4
line 272
;272:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $216
ASGNP4
line 273
;273:			break;
ADDRGP4 $200
JUMPV
LABELV $217
line 275
;274:		case MOD_ROCKET_SPLASH:
;275:			message = "almost dodged";
ADDRLP4 40
ADDRGP4 $218
ASGNP4
line 276
;276:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $216
ASGNP4
line 277
;277:			break;
ADDRGP4 $200
JUMPV
LABELV $219
line 279
;278:		case MOD_PLASMA:
;279:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $220
ASGNP4
line 280
;280:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $221
ASGNP4
line 281
;281:			break;
ADDRGP4 $200
JUMPV
LABELV $222
line 283
;282:		case MOD_PLASMA_SPLASH:
;283:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $220
ASGNP4
line 284
;284:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $221
ASGNP4
line 285
;285:			break;
ADDRGP4 $200
JUMPV
LABELV $223
line 287
;286:		case MOD_RAILGUN:
;287:			message = "was railed by";
ADDRLP4 40
ADDRGP4 $224
ASGNP4
line 288
;288:			break;
ADDRGP4 $200
JUMPV
LABELV $225
line 290
;289:		case MOD_LIGHTNING:
;290:			message = "was electrocuted by";
ADDRLP4 40
ADDRGP4 $226
ASGNP4
line 291
;291:			break;
ADDRGP4 $200
JUMPV
LABELV $227
line 294
;292:		case MOD_BFG:
;293:		case MOD_BFG_SPLASH:
;294:			message = "was blasted by";
ADDRLP4 40
ADDRGP4 $228
ASGNP4
line 295
;295:			message2 = "'s BFG";
ADDRLP4 88
ADDRGP4 $229
ASGNP4
line 296
;296:			break;
ADDRGP4 $200
JUMPV
LABELV $230
line 299
;297:		// EMERALD: MOD for uberweapons
;298:		case MOD_EXP_SHOTGUN:
;299:			message = "was blown to bits by";
ADDRLP4 40
ADDRGP4 $231
ASGNP4
line 300
;300:			message2 = "'s explosive shotgun";
ADDRLP4 88
ADDRGP4 $232
ASGNP4
line 301
;301:			break;
ADDRGP4 $200
JUMPV
LABELV $233
line 303
;302:		case MOD_EXP_SHOTGUN_SPLASH:
;303:			message = "was blown to bits by";
ADDRLP4 40
ADDRGP4 $231
ASGNP4
line 304
;304:			message2 = "'s explosive shotgun";
ADDRLP4 88
ADDRGP4 $232
ASGNP4
line 305
;305:			break;
ADDRGP4 $200
JUMPV
LABELV $234
line 307
;306:		case MOD_MULTI_GRENADE:
;307:			message = "couldn't stay away from";
ADDRLP4 40
ADDRGP4 $235
ASGNP4
line 308
;308:			message2 = "'s multi grenades";
ADDRLP4 88
ADDRGP4 $236
ASGNP4
line 309
;309:			break;
ADDRGP4 $200
JUMPV
LABELV $237
line 311
;310:		case MOD_MULTI_GRENADE_SPLASH:
;311:			message = "couldn't stay away from";
ADDRLP4 40
ADDRGP4 $235
ASGNP4
line 312
;312:			message2 = "'s multi grenades";
ADDRLP4 88
ADDRGP4 $236
ASGNP4
line 313
;313:			break;
ADDRGP4 $200
JUMPV
LABELV $238
line 315
;314:		case MOD_ROCKET_HOMING:
;315:			message = "was hunted down by";
ADDRLP4 40
ADDRGP4 $239
ASGNP4
line 316
;316:			message2 = "'s homing rocket";
ADDRLP4 88
ADDRGP4 $240
ASGNP4
line 317
;317:			break;
ADDRGP4 $200
JUMPV
LABELV $241
line 319
;318:		case MOD_ROCKET_HOMING_SPLASH:
;319:			message = "was hunted down by";
ADDRLP4 40
ADDRGP4 $239
ASGNP4
line 320
;320:			message2 = "'s homing rocket";
ADDRLP4 88
ADDRGP4 $240
ASGNP4
line 321
;321:			break;
ADDRGP4 $200
JUMPV
LABELV $242
line 323
;322:		case MOD_ARC_LIGHTNING:
;323:			message = "was given a jolt by";
ADDRLP4 40
ADDRGP4 $243
ASGNP4
line 324
;324:			break;
ADDRGP4 $200
JUMPV
LABELV $244
line 326
;325:		case MOD_ARC_LIGHTNING_INDIRECT:
;326:			message = "was an excellent conductor of";
ADDRLP4 40
ADDRGP4 $245
ASGNP4
line 327
;327:			message2 = "'s arc lightning gun";
ADDRLP4 88
ADDRGP4 $246
ASGNP4
line 328
;328:			break;
ADDRGP4 $200
JUMPV
LABELV $247
line 330
;329:		case MOD_TOXIC_RAILGUN:
;330:			message = "was railed by";
ADDRLP4 40
ADDRGP4 $224
ASGNP4
line 331
;331:			break;
ADDRGP4 $200
JUMPV
LABELV $248
line 333
;332:		case MOD_ION_PLASMA:
;333:			message = "was ionized by";
ADDRLP4 40
ADDRGP4 $249
ASGNP4
line 334
;334:			break;
ADDRGP4 $200
JUMPV
LABELV $250
line 336
;335:		case MOD_ION_PLASMA_SPLASH:
;336:			message = "was ionized by";
ADDRLP4 40
ADDRGP4 $249
ASGNP4
line 337
;337:			break;
ADDRGP4 $200
JUMPV
LABELV $251
line 339
;338:		case MOD_RAMPAGE:
;339:			message = "got a little too close to";
ADDRLP4 40
ADDRGP4 $252
ASGNP4
line 340
;340:			break;
ADDRGP4 $200
JUMPV
LABELV $253
line 362
;341:#ifdef MISSIONPACK
;342:		case MOD_NAIL:
;343:			message = "was nailed by";
;344:			break;
;345:		case MOD_CHAINGUN:
;346:			message = "got lead poisoning from";
;347:			message2 = "'s Chaingun";
;348:			break;
;349:		case MOD_PROXIMITY_MINE:
;350:			message = "was too close to";
;351:			message2 = "'s Prox Mine";
;352:			break;
;353:		case MOD_KAMIKAZE:
;354:			message = "falls to";
;355:			message2 = "'s Kamikaze blast";
;356:			break;
;357:		case MOD_JUICED:
;358:			message = "was juiced by";
;359:			break;
;360:#endif
;361:		case MOD_TELEFRAG:
;362:			message = "tried to invade";
ADDRLP4 40
ADDRGP4 $254
ASGNP4
line 363
;363:			message2 = "'s personal space";
ADDRLP4 88
ADDRGP4 $255
ASGNP4
line 364
;364:			break;
ADDRGP4 $200
JUMPV
LABELV $199
line 366
;365:		default:
;366:			message = "was killed by";
ADDRLP4 40
ADDRGP4 $256
ASGNP4
line 367
;367:			break;
LABELV $200
line 370
;368:		}
;369:
;370:		if (message) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $259
line 371
;371:			CG_Printf( "%s %s %s%s\n", 
ADDRGP4 $261
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 373
;372:				targetName, message, attackerName, message2);
;373:			return;
ADDRGP4 $105
JUMPV
LABELV $259
line 375
;374:		}
;375:	}
LABELV $197
line 378
;376:
;377:	// we don't know what it was
;378:	CG_Printf( "%s died.\n", targetName );
ADDRGP4 $262
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 379
;379:}
LABELV $105
endproc CG_Obituary 132 20
proc CG_UseItem 32 16
line 388
;380:
;381://==========================================================================
;382:
;383:/*
;384:===============
;385:CG_UseItem
;386:===============
;387:*/
;388:static void CG_UseItem( centity_t *cent ) {
line 394
;389:	clientInfo_t *ci;
;390:	int			itemNum, clientNum;
;391:	gitem_t		*item;
;392:	entityState_t *es;
;393:
;394:	es = &cent->currentState;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 396
;395:	
;396:	itemNum = (es->event & ~EV_EVENT_BITS) - EV_USE_ITEM0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 25
SUBI4
ASGNI4
line 397
;397:	if ( itemNum < 0 || itemNum > HI_NUM_HOLDABLE ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $266
ADDRLP4 0
INDIRI4
CNSTI4 8
LEI4 $264
LABELV $266
line 398
;398:		itemNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 399
;399:	}
LABELV $264
line 402
;400:
;401:	// print a message if the local player
;402:	if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $267
line 403
;403:		if ( !itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $270
line 404
;404:			CG_CenterPrint( "No item to use", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRGP4 $272
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 405
;405:		} else {
ADDRGP4 $271
JUMPV
LABELV $270
line 406
;406:			item = BG_FindItemForHoldable( itemNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForHoldable
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 407
;407:			CG_CenterPrint( va("Use %s", item->pickup_name), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRGP4 $273
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 408
;408:		}
LABELV $271
line 409
;409:	}
LABELV $267
line 411
;410:
;411:	switch ( itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $274
ADDRLP4 0
INDIRI4
CNSTI4 7
GTI4 $274
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $290
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $290
address $276
address $275
address $280
address $274
address $274
address $274
address $274
address $287
code
LABELV $274
LABELV $276
line 414
;412:	default:
;413:	case HI_NONE:
;414:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useNothingSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+152340+592
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 415
;415:		break;
ADDRGP4 $275
JUMPV
line 418
;416:
;417:	case HI_TELEPORTER:
;418:		break;
LABELV $280
line 421
;419:
;420:	case HI_MEDKIT:
;421:		clientNum = cent->currentState.clientNum;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 422
;422:		if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 28
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $281
ADDRLP4 28
INDIRI4
CNSTI4 64
GEI4 $281
line 423
;423:			ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 16
CNSTI4 1708
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 424
;424:			ci->medkitUsageTime = cg.time;
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 425
;425:		}
LABELV $281
line 426
;426:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.medkitSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+152340+916
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 427
;427:		break;
ADDRGP4 $275
JUMPV
LABELV $287
line 430
;428:
;429:	case HI_TUNER:
;430:		trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.tunerSound);
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+152340+920
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 431
;431:		break;
LABELV $275
line 445
;432:
;433:#ifdef MISSIONPACK
;434:	case HI_KAMIKAZE:
;435:		break;
;436:
;437:	case HI_PORTAL:
;438:		break;
;439:	case HI_INVULNERABILITY:
;440:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useInvulnerabilitySound );
;441:		break;
;442:#endif
;443:	}
;444:
;445:}
LABELV $263
endproc CG_UseItem 32 16
proc CG_ItemPickup 0 0
line 454
;446:
;447:/*
;448:================
;449:CG_ItemPickup
;450:
;451:A new item was picked up this frame
;452:================
;453:*/
;454:static void CG_ItemPickup( int itemNum ) {
line 455
;455:	cg.itemPickup = itemNum;
ADDRGP4 cg+128780
ADDRFP4 0
INDIRI4
ASGNI4
line 456
;456:	cg.itemPickupTime = cg.time;
ADDRGP4 cg+128784
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 457
;457:	cg.itemPickupBlendTime = cg.time;
ADDRGP4 cg+128788
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 459
;458:	// see if it should be the grabbed weapon
;459:	if ( bg_itemlist[itemNum].giType == IT_WEAPON ) {
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $297
line 461
;460:		// select it immediately
;461:		if ( cg_autoswitch.integer && bg_itemlist[itemNum].giTag != WP_MACHINEGUN ) {
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 0
EQI4 $300
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
EQI4 $300
line 462
;462:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+128792
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 463
;463:			cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+113060
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 464
;464:		}
LABELV $300
line 465
;465:	}
LABELV $297
line 467
;466:
;467:}
LABELV $291
endproc CG_ItemPickup 0 0
export CG_PainEvent
proc CG_PainEvent 12 16
line 477
;468:
;469:
;470:/*
;471:================
;472:CG_PainEvent
;473:
;474:Also called by playerstate transition
;475:================
;476:*/
;477:void CG_PainEvent( centity_t *cent, int health ) {
line 481
;478:	char	*snd;
;479:
;480:	// don't do more than two pain sounds a second
;481:	if ( cg.time - cent->pe.painTime < 500 ) {
ADDRGP4 cg+111708
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
SUBI4
CNSTI4 500
GEI4 $309
line 482
;482:		return;
ADDRGP4 $308
JUMPV
LABELV $309
line 485
;483:	}
;484:
;485:	if ( health < 25 ) {
ADDRFP4 4
INDIRI4
CNSTI4 25
GEI4 $312
line 486
;486:		snd = "*pain25_1.wav";
ADDRLP4 0
ADDRGP4 $314
ASGNP4
line 487
;487:	} else if ( health < 50 ) {
ADDRGP4 $313
JUMPV
LABELV $312
ADDRFP4 4
INDIRI4
CNSTI4 50
GEI4 $315
line 488
;488:		snd = "*pain50_1.wav";
ADDRLP4 0
ADDRGP4 $317
ASGNP4
line 489
;489:	} else if ( health < 75 ) {
ADDRGP4 $316
JUMPV
LABELV $315
ADDRFP4 4
INDIRI4
CNSTI4 75
GEI4 $318
line 490
;490:		snd = "*pain75_1.wav";
ADDRLP4 0
ADDRGP4 $320
ASGNP4
line 491
;491:	} else {
ADDRGP4 $319
JUMPV
LABELV $318
line 492
;492:		snd = "*pain100_1.wav";
ADDRLP4 0
ADDRGP4 $321
ASGNP4
line 493
;493:	}
LABELV $319
LABELV $316
LABELV $313
line 494
;494:	trap_S_StartSound( NULL, cent->currentState.number, CHAN_VOICE, 
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 498
;495:		CG_CustomSound( cent->currentState.number, snd ) );
;496:
;497:	// save pain time for programitic twitch animation
;498:	cent->pe.painTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 499
;499:	cent->pe.painDirection ^= 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 500
;500:}
LABELV $308
endproc CG_PainEvent 12 16
lit
align 4
LABELV $483
byte 4 0
byte 4 0
byte 4 1065353216
export CG_EntityEvent
code
proc CG_EntityEvent 116 48
line 513
;501:
;502:
;503:
;504:/*
;505:==============
;506:CG_EntityEvent
;507:
;508:An entity has an event value
;509:also called by CG_CheckPlayerstateEvents
;510:==============
;511:*/
;512:#define	DEBUGNAME(x) if(cg_debugEvents.integer){CG_Printf(x"\n");}
;513:void CG_EntityEvent( centity_t *cent, vec3_t position ) {
line 521
;514:	entityState_t	*es;
;515:	int				event;
;516:	vec3_t			dir;
;517:	const char		*s;
;518:	int				clientNum;
;519:	clientInfo_t	*ci;
;520:
;521:	es = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 522
;522:	event = es->event & ~EV_EVENT_BITS;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 524
;523:
;524:	if ( cg_debugEvents.integer ) {
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $324
line 525
;525:		CG_Printf( "ent:%3i  event:%3i ", es->number, event );
ADDRGP4 $327
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 526
;526:	}
LABELV $324
line 528
;527:
;528:	if ( !event ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $328
line 529
;529:		DEBUGNAME("ZEROEVENT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $323
ADDRGP4 $333
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 530
;530:		return;
ADDRGP4 $323
JUMPV
LABELV $328
line 533
;531:	}
;532:
;533:	clientNum = es->clientNum;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 534
;534:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $336
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $334
LABELV $336
line 535
;535:		clientNum = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 536
;536:	}
LABELV $334
line 537
;537:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 12
CNSTI4 1708
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 539
;538:
;539:	switch ( event ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $338
ADDRLP4 8
INDIRI4
CNSTI4 94
GTI4 $338
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1046-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1046
address $340
address $350
address $361
address $372
address $383
address $448
address $448
address $448
address $448
address $394
address $422
address $434
address $408
address $478
address $490
address $501
address $508
address $515
address $522
address $528
address $546
address $560
address $568
address $575
address $580
address $585
address $590
address $595
address $600
address $605
address $610
address $615
address $620
address $625
address $630
address $635
address $640
address $645
address $650
address $338
address $676
address $669
address $655
address $662
address $684
address $695
address $753
address $762
address $773
address $738
address $733
address $711
address $716
address $721
address $726
address $743
address $338
address $748
address $985
address $991
address $997
address $1003
address $1009
address $1015
address $1021
address $338
address $1026
address $338
address $1031
address $338
address $1036
address $338
address $897
address $905
address $905
address $905
address $911
address $916
address $929
address $942
address $955
address $966
address $706
address $338
address $338
address $338
address $338
address $338
address $338
address $338
address $338
address $980
address $975
address $495
code
LABELV $340
line 544
;540:	//
;541:	// movement generated events
;542:	//
;543:	case EV_FOOTSTEP:
;544:		DEBUGNAME("EV_FOOTSTEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $341
ADDRGP4 $344
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $341
line 545
;545:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $339
line 546
;546:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 cgs+152340+600
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 548
;547:				cgs.media.footsteps[ ci->footsteps ][rand()&3] );
;548:		}
line 549
;549:		break;
ADDRGP4 $339
JUMPV
LABELV $350
line 551
;550:	case EV_FOOTSTEP_METAL:
;551:		DEBUGNAME("EV_FOOTSTEP_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $351
ADDRGP4 $354
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $351
line 552
;552:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $339
line 553
;553:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+600+80
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 555
;554:				cgs.media.footsteps[ FOOTSTEP_METAL ][rand()&3] );
;555:		}
line 556
;556:		break;
ADDRGP4 $339
JUMPV
LABELV $361
line 558
;557:	case EV_FOOTSPLASH:
;558:		DEBUGNAME("EV_FOOTSPLASH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $362
ADDRGP4 $365
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $362
line 559
;559:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $339
line 560
;560:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+600+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 562
;561:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;562:		}
line 563
;563:		break;
ADDRGP4 $339
JUMPV
LABELV $372
line 565
;564:	case EV_FOOTWADE:
;565:		DEBUGNAME("EV_FOOTWADE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $373
ADDRGP4 $376
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $373
line 566
;566:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $339
line 567
;567:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+600+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 569
;568:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;569:		}
line 570
;570:		break;
ADDRGP4 $339
JUMPV
LABELV $383
line 572
;571:	case EV_SWIM:
;572:		DEBUGNAME("EV_SWIM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $384
ADDRGP4 $387
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $384
line 573
;573:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $339
line 574
;574:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+600+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 576
;575:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;576:		}
line 577
;577:		break;
ADDRGP4 $339
JUMPV
LABELV $394
line 581
;578:
;579:
;580:	case EV_FALL_SHORT:
;581:		DEBUGNAME("EV_FALL_SHORT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $395
ADDRGP4 $398
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $395
line 582
;582:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.landSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+784
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 583
;583:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+111740+140
INDIRI4
NEI4 $339
line 585
;584:			// smooth landing z changes
;585:			cg.landChange = -8;
ADDRGP4 cg+113052
CNSTF4 3238002688
ASGNF4
line 586
;586:			cg.landTime = cg.time;
ADDRGP4 cg+113056
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 587
;587:		}
line 588
;588:		break;
ADDRGP4 $339
JUMPV
LABELV $408
line 590
;589:	case EV_BOUNCE:
;590:		DEBUGNAME("EV_BOUNCE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $409
ADDRGP4 $412
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $409
line 591
;591:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.bounceSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+796
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 592
;592:		if (clientNum == cg.predictedPlayerState.clientNum) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+111740+140
INDIRI4
NEI4 $339
line 594
;593:			// smooth landing z changes
;594:			cg.landChange = -8;
ADDRGP4 cg+113052
CNSTF4 3238002688
ASGNF4
line 595
;595:			cg.landTime = cg.time;
ADDRGP4 cg+113056
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 596
;596:		}
line 597
;597:		break;
ADDRGP4 $339
JUMPV
LABELV $422
line 599
;598:	case EV_FALL_MEDIUM:
;599:		DEBUGNAME("EV_FALL_MEDIUM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $423
ADDRGP4 $426
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $423
line 601
;600:		// use normal pain sound
;601:		trap_S_StartSound( NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*pain100_1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $321
ARGP4
ADDRLP4 40
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 602
;602:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+111740+140
INDIRI4
NEI4 $339
line 604
;603:			// smooth landing z changes
;604:			cg.landChange = -16;
ADDRGP4 cg+113052
CNSTF4 3246391296
ASGNF4
line 605
;605:			cg.landTime = cg.time;
ADDRGP4 cg+113056
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 606
;606:		}
line 607
;607:		break;
ADDRGP4 $339
JUMPV
LABELV $434
line 609
;608:	case EV_FALL_FAR:
;609:		DEBUGNAME("EV_FALL_FAR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $435
ADDRGP4 $438
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $435
line 610
;610:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*fall1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $439
ARGP4
ADDRLP4 44
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 611
;611:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 612
;612:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+111740+140
INDIRI4
NEI4 $339
line 614
;613:			// smooth landing z changes
;614:			cg.landChange = -24;
ADDRGP4 cg+113052
CNSTF4 3250585600
ASGNF4
line 615
;615:			cg.landTime = cg.time;
ADDRGP4 cg+113056
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 616
;616:		}
line 617
;617:		break;
ADDRGP4 $339
JUMPV
LABELV $448
line 623
;618:
;619:	case EV_STEP_4:
;620:	case EV_STEP_8:
;621:	case EV_STEP_12:
;622:	case EV_STEP_16:		// smooth out step up transitions
;623:		DEBUGNAME("EV_STEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $449
ADDRGP4 $452
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $449
line 624
;624:	{
line 629
;625:		float	oldStep;
;626:		int		delta;
;627:		int		step;
;628:
;629:		if ( clientNum != cg.predictedPlayerState.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+111740+140
INDIRI4
EQI4 $453
line 630
;630:			break;
ADDRGP4 $339
JUMPV
LABELV $453
line 633
;631:		}
;632:		// if we are interpolating, we don't need to smooth steps
;633:		if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ||
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRGP4 cg+8
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $465
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 60
INDIRI4
NEI4 $465
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $465
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $457
LABELV $465
line 634
;634:			cg_nopredict.integer || cg_synchronousClients.integer ) {
line 635
;635:			break;
ADDRGP4 $339
JUMPV
LABELV $457
line 638
;636:		}
;637:		// check for stepping up before a previous step is completed
;638:		delta = cg.time - cg.stepTime;
ADDRLP4 48
ADDRGP4 cg+111708
INDIRI4
ADDRGP4 cg+113040
INDIRI4
SUBI4
ASGNI4
line 639
;639:		if (delta < STEP_TIME) {
ADDRLP4 48
INDIRI4
CNSTI4 200
GEI4 $468
line 640
;640:			oldStep = cg.stepChange * (STEP_TIME - delta) / STEP_TIME;
ADDRLP4 52
ADDRGP4 cg+113036
INDIRF4
CNSTI4 200
ADDRLP4 48
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 641
;641:		} else {
ADDRGP4 $469
JUMPV
LABELV $468
line 642
;642:			oldStep = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 643
;643:		}
LABELV $469
line 646
;644:
;645:		// add this amount
;646:		step = 4 * (event - EV_STEP_4 + 1 );
ADDRLP4 56
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 24
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 647
;647:		cg.stepChange = oldStep + step;
ADDRGP4 cg+113036
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 648
;648:		if ( cg.stepChange > MAX_STEP_CHANGE ) {
ADDRGP4 cg+113036
INDIRF4
CNSTF4 1107296256
LEF4 $472
line 649
;649:			cg.stepChange = MAX_STEP_CHANGE;
ADDRGP4 cg+113036
CNSTF4 1107296256
ASGNF4
line 650
;650:		}
LABELV $472
line 651
;651:		cg.stepTime = cg.time;
ADDRGP4 cg+113040
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 652
;652:		break;
ADDRGP4 $339
JUMPV
LABELV $478
line 656
;653:	}
;654:
;655:	case EV_JUMP_PAD:
;656:		DEBUGNAME("EV_JUMP_PAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $479
ADDRGP4 $482
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $479
line 658
;657://		CG_Printf( "EV_JUMP_PAD w/effect #%i\n", es->eventParm );
;658:		{
line 660
;659:			localEntity_t	*smoke;
;660:			vec3_t			up = {0, 0, 1};
ADDRLP4 48
ADDRGP4 $483
INDIRB
ASGNB 12
line 663
;661:
;662:
;663:			smoke = CG_SmokePuff( cent->lerpOrigin, up, 
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 48
ARGP4
CNSTF4 1107296256
ARGF4
ADDRLP4 64
CNSTF4 1065353216
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 cg+111708
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+152340+276
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 68
INDIRP4
ASGNP4
line 670
;664:						  32, 
;665:						  1, 1, 1, 0.33f,
;666:						  1000, 
;667:						  cg.time, 0,
;668:						  LEF_PUFF_DONT_SCALE, 
;669:						  cgs.media.smokePuffShader );
;670:		}
line 673
;671:
;672:		// boing sound at origin, jump sound on player
;673:		trap_S_StartSound ( cent->lerpOrigin, -1, CHAN_VOICE, cgs.media.jumpPadSound );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+152340+792
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 674
;674:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $489
ARGP4
ADDRLP4 48
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 675
;675:		break;
ADDRGP4 $339
JUMPV
LABELV $490
line 678
;676:
;677:	case EV_JUMP:
;678:		DEBUGNAME("EV_JUMP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $491
ADDRGP4 $494
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $491
line 679
;679:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $489
ARGP4
ADDRLP4 52
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 680
;680:		break;
ADDRGP4 $339
JUMPV
LABELV $495
line 682
;681:	case EV_TAUNT:
;682:		DEBUGNAME("EV_TAUNT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $496
ADDRGP4 $499
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $496
line 683
;683:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*taunt.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $500
ARGP4
ADDRLP4 56
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 684
;684:		break;
ADDRGP4 $339
JUMPV
LABELV $501
line 712
;685:#ifdef MISSIONPACK
;686:	case EV_TAUNT_YES:
;687:		DEBUGNAME("EV_TAUNT_YES");
;688:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_YES);
;689:		break;
;690:	case EV_TAUNT_NO:
;691:		DEBUGNAME("EV_TAUNT_NO");
;692:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_NO);
;693:		break;
;694:	case EV_TAUNT_FOLLOWME:
;695:		DEBUGNAME("EV_TAUNT_FOLLOWME");
;696:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_FOLLOWME);
;697:		break;
;698:	case EV_TAUNT_GETFLAG:
;699:		DEBUGNAME("EV_TAUNT_GETFLAG");
;700:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONGETFLAG);
;701:		break;
;702:	case EV_TAUNT_GUARDBASE:
;703:		DEBUGNAME("EV_TAUNT_GUARDBASE");
;704:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONDEFENSE);
;705:		break;
;706:	case EV_TAUNT_PATROL:
;707:		DEBUGNAME("EV_TAUNT_PATROL");
;708:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONPATROL);
;709:		break;
;710:#endif
;711:	case EV_WATER_TOUCH:
;712:		DEBUGNAME("EV_WATER_TOUCH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $502
ADDRGP4 $505
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $502
line 713
;713:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+900
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 714
;714:		break;
ADDRGP4 $339
JUMPV
LABELV $508
line 716
;715:	case EV_WATER_LEAVE:
;716:		DEBUGNAME("EV_WATER_LEAVE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $509
ADDRGP4 $512
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $509
line 717
;717:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+904
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 718
;718:		break;
ADDRGP4 $339
JUMPV
LABELV $515
line 720
;719:	case EV_WATER_UNDER:
;720:		DEBUGNAME("EV_WATER_UNDER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $516
ADDRGP4 $519
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $516
line 721
;721:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrUnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+908
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 722
;722:		break;
ADDRGP4 $339
JUMPV
LABELV $522
line 724
;723:	case EV_WATER_CLEAR:
;724:		DEBUGNAME("EV_WATER_CLEAR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $523
ADDRGP4 $526
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $523
line 725
;725:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*gasp.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $527
ARGP4
ADDRLP4 60
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 726
;726:		break;
ADDRGP4 $339
JUMPV
LABELV $528
line 729
;727:
;728:	case EV_ITEM_PICKUP:
;729:		DEBUGNAME("EV_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $529
ADDRGP4 $532
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $529
line 730
;730:		{
line 734
;731:			gitem_t	*item;
;732:			int		index;
;733:
;734:			index = es->eventParm;		// player predicted
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 736
;735:
;736:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 72
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 1
LTI4 $535
ADDRLP4 72
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $533
LABELV $535
line 737
;737:				break;
ADDRGP4 $339
JUMPV
LABELV $533
line 739
;738:			}
;739:			item = &bg_itemlist[ index ];
ADDRLP4 68
CNSTI4 52
ADDRLP4 64
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 743
;740:
;741:			// powerups and team items will have a separate global sound, this one
;742:			// will be played at prediction time
;743:			if ( item->giType == IT_POWERUP || item->giType == IT_TEAM) {
ADDRLP4 76
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 5
EQI4 $538
ADDRLP4 76
INDIRI4
CNSTI4 8
NEI4 $536
LABELV $538
line 744
;744:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.n_healthSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+1056
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 745
;745:			} else if (item->giType == IT_PERSISTANT_POWERUP) {
ADDRGP4 $537
JUMPV
LABELV $536
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $541
line 762
;746:#ifdef MISSIONPACK
;747:				switch (item->giTag ) {
;748:					case PW_SCOUT:
;749:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.scoutSound );
;750:					break;
;751:					case PW_GUARD:
;752:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.guardSound );
;753:					break;
;754:					case PW_DOUBLER:
;755:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.doublerSound );
;756:					break;
;757:					case PW_AMMOREGEN:
;758:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.ammoregenSound );
;759:					break;
;760:				}
;761:#endif
;762:			} else {
ADDRGP4 $542
JUMPV
LABELV $541
line 763
;763:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 80
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 764
;764:			}
LABELV $542
LABELV $537
line 767
;765:
;766:			// show icon and name on status bar
;767:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $339
line 768
;768:				CG_ItemPickup( index );
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 769
;769:			}
line 770
;770:		}
line 771
;771:		break;
ADDRGP4 $339
JUMPV
LABELV $546
line 774
;772:
;773:	case EV_GLOBAL_ITEM_PICKUP:
;774:		DEBUGNAME("EV_GLOBAL_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $547
ADDRGP4 $550
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $547
line 775
;775:		{
line 779
;776:			gitem_t	*item;
;777:			int		index;
;778:
;779:			index = es->eventParm;		// player predicted
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 781
;780:
;781:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 72
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 1
LTI4 $553
ADDRLP4 72
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $551
LABELV $553
line 782
;782:				break;
ADDRGP4 $339
JUMPV
LABELV $551
line 784
;783:			}
;784:			item = &bg_itemlist[ index ];
ADDRLP4 68
CNSTI4 52
ADDRLP4 64
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 786
;785:			// powerup pickups are global
;786:			if( item->pickup_sound ) {
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $554
line 787
;787:				trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 788
;788:			}
LABELV $554
line 791
;789:
;790:			// show icon and name on status bar
;791:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $339
line 792
;792:				CG_ItemPickup( index );
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 793
;793:			}
line 794
;794:		}
line 795
;795:		break;
ADDRGP4 $339
JUMPV
LABELV $560
line 801
;796:
;797:	//
;798:	// weapon events
;799:	//
;800:	case EV_NOAMMO:
;801:		DEBUGNAME("EV_NOAMMO");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $561
ADDRGP4 $564
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $561
line 803
;802://		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.noAmmoSound );
;803:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $339
line 804
;804:			CG_OutOfAmmoChange();
ADDRGP4 CG_OutOfAmmoChange
CALLV
pop
line 805
;805:		}
line 806
;806:		break;
ADDRGP4 $339
JUMPV
LABELV $568
line 808
;807:	case EV_CHANGE_WEAPON:
;808:		DEBUGNAME("EV_CHANGE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $569
ADDRGP4 $572
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $569
line 809
;809:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.selectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+588
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 810
;810:		break;
ADDRGP4 $339
JUMPV
LABELV $575
line 812
;811:	case EV_FIRE_WEAPON:
;812:		DEBUGNAME("EV_FIRE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $576
ADDRGP4 $579
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $576
line 813
;813:		CG_FireWeapon( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FireWeapon
CALLV
pop
line 814
;814:		break;
ADDRGP4 $339
JUMPV
LABELV $580
line 817
;815:
;816:	case EV_USE_ITEM0:
;817:		DEBUGNAME("EV_USE_ITEM0");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $581
ADDRGP4 $584
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $581
line 818
;818:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 819
;819:		break;
ADDRGP4 $339
JUMPV
LABELV $585
line 821
;820:	case EV_USE_ITEM1:
;821:		DEBUGNAME("EV_USE_ITEM1");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $586
ADDRGP4 $589
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $586
line 822
;822:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 823
;823:		break;
ADDRGP4 $339
JUMPV
LABELV $590
line 825
;824:	case EV_USE_ITEM2:
;825:		DEBUGNAME("EV_USE_ITEM2");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $591
ADDRGP4 $594
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $591
line 826
;826:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 827
;827:		break;
ADDRGP4 $339
JUMPV
LABELV $595
line 829
;828:	case EV_USE_ITEM3:
;829:		DEBUGNAME("EV_USE_ITEM3");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $596
ADDRGP4 $599
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $596
line 830
;830:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 831
;831:		break;
ADDRGP4 $339
JUMPV
LABELV $600
line 833
;832:	case EV_USE_ITEM4:
;833:		DEBUGNAME("EV_USE_ITEM4");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $601
ADDRGP4 $604
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $601
line 834
;834:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 835
;835:		break;
ADDRGP4 $339
JUMPV
LABELV $605
line 837
;836:	case EV_USE_ITEM5:
;837:		DEBUGNAME("EV_USE_ITEM5");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $606
ADDRGP4 $609
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $606
line 838
;838:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 839
;839:		break;
ADDRGP4 $339
JUMPV
LABELV $610
line 841
;840:	case EV_USE_ITEM6:
;841:		DEBUGNAME("EV_USE_ITEM6");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $611
ADDRGP4 $614
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $611
line 842
;842:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 843
;843:		break;
ADDRGP4 $339
JUMPV
LABELV $615
line 845
;844:	case EV_USE_ITEM7:
;845:		DEBUGNAME("EV_USE_ITEM7");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $616
ADDRGP4 $619
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $616
line 846
;846:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 847
;847:		break;
ADDRGP4 $339
JUMPV
LABELV $620
line 849
;848:	case EV_USE_ITEM8:
;849:		DEBUGNAME("EV_USE_ITEM8");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $621
ADDRGP4 $624
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $621
line 850
;850:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 851
;851:		break;
ADDRGP4 $339
JUMPV
LABELV $625
line 853
;852:	case EV_USE_ITEM9:
;853:		DEBUGNAME("EV_USE_ITEM9");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $626
ADDRGP4 $629
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $626
line 854
;854:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 855
;855:		break;
ADDRGP4 $339
JUMPV
LABELV $630
line 857
;856:	case EV_USE_ITEM10:
;857:		DEBUGNAME("EV_USE_ITEM10");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $631
ADDRGP4 $634
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $631
line 858
;858:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 859
;859:		break;
ADDRGP4 $339
JUMPV
LABELV $635
line 861
;860:	case EV_USE_ITEM11:
;861:		DEBUGNAME("EV_USE_ITEM11");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $636
ADDRGP4 $639
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $636
line 862
;862:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 863
;863:		break;
ADDRGP4 $339
JUMPV
LABELV $640
line 865
;864:	case EV_USE_ITEM12:
;865:		DEBUGNAME("EV_USE_ITEM12");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $641
ADDRGP4 $644
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $641
line 866
;866:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 867
;867:		break;
ADDRGP4 $339
JUMPV
LABELV $645
line 869
;868:	case EV_USE_ITEM13:
;869:		DEBUGNAME("EV_USE_ITEM13");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $646
ADDRGP4 $649
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $646
line 870
;870:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 871
;871:		break;
ADDRGP4 $339
JUMPV
LABELV $650
line 873
;872:	case EV_USE_ITEM14:
;873:		DEBUGNAME("EV_USE_ITEM14");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $651
ADDRGP4 $654
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $651
line 874
;874:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 875
;875:		break;
ADDRGP4 $339
JUMPV
LABELV $655
line 883
;876:
;877:	//=================================================================
;878:
;879:	//
;880:	// other events
;881:	//
;882:	case EV_PLAYER_TELEPORT_IN:
;883:		DEBUGNAME("EV_PLAYER_TELEPORT_IN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $656
ADDRGP4 $659
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $656
line 884
;884:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+764
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 885
;885:		CG_SpawnEffect( position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 886
;886:		break;
ADDRGP4 $339
JUMPV
LABELV $662
line 889
;887:
;888:	case EV_PLAYER_TELEPORT_OUT:
;889:		DEBUGNAME("EV_PLAYER_TELEPORT_OUT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $663
ADDRGP4 $666
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $663
line 890
;890:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+768
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 891
;891:		CG_SpawnEffect(  position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 892
;892:		break;
ADDRGP4 $339
JUMPV
LABELV $669
line 895
;893:
;894:	case EV_ITEM_POP:
;895:		DEBUGNAME("EV_ITEM_POP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $670
ADDRGP4 $673
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $670
line 896
;896:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+776
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 897
;897:		break;
ADDRGP4 $339
JUMPV
LABELV $676
line 899
;898:	case EV_ITEM_RESPAWN:
;899:		DEBUGNAME("EV_ITEM_RESPAWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $677
ADDRGP4 $680
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $677
line 900
;900:		cent->miscTime = cg.time;	// scale up from this
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 901
;901:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+776
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 902
;902:		break;
ADDRGP4 $339
JUMPV
LABELV $684
line 905
;903:
;904:	case EV_GRENADE_BOUNCE:
;905:		DEBUGNAME("EV_GRENADE_BOUNCE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $685
ADDRGP4 $688
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $685
line 906
;906:		if ( rand() & 1 ) {
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $689
line 907
;907:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb1aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+1060
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 908
;908:		} else {
ADDRGP4 $339
JUMPV
LABELV $689
line 909
;909:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb2aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+1064
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 910
;910:		}
line 911
;911:		break;
ADDRGP4 $339
JUMPV
LABELV $695
line 914
;912:
;913:	case EV_ION_BOUNCE:
;914:		DEBUGNAME("EV_ION_BOUNCE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $696
ADDRGP4 $699
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $696
line 915
;915:		if (rand() & 1) {
ADDRLP4 68
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $700
line 916
;916:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.ionb1Sound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+1068
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 917
;917:		}
ADDRGP4 $339
JUMPV
LABELV $700
line 918
;918:		else {
line 919
;919:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.ionb2Sound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+152340+1072
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 920
;920:		}
line 921
;921:		break;
ADDRGP4 $339
JUMPV
LABELV $706
line 965
;922:
;923:#ifdef MISSIONPACK
;924:	case EV_PROXIMITY_MINE_STICK:
;925:		DEBUGNAME("EV_PROXIMITY_MINE_STICK");
;926:		if( es->eventParm & SURF_FLESH ) {
;927:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimplSound );
;928:		} else 	if( es->eventParm & SURF_METALSTEPS ) {
;929:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpmSound );
;930:		} else {
;931:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpdSound );
;932:		}
;933:		break;
;934:
;935:	case EV_PROXIMITY_MINE_TRIGGER:
;936:		DEBUGNAME("EV_PROXIMITY_MINE_TRIGGER");
;937:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbactvSound );
;938:		break;
;939:	case EV_KAMIKAZE:
;940:		DEBUGNAME("EV_KAMIKAZE");
;941:		CG_KamikazeEffect( cent->lerpOrigin );
;942:		break;
;943:	case EV_OBELISKEXPLODE:
;944:		DEBUGNAME("EV_OBELISKEXPLODE");
;945:		CG_ObeliskExplode( cent->lerpOrigin, es->eventParm );
;946:		break;
;947:	case EV_OBELISKPAIN:
;948:		DEBUGNAME("EV_OBELISKPAIN");
;949:		CG_ObeliskPain( cent->lerpOrigin );
;950:		break;
;951:	case EV_INVUL_IMPACT:
;952:		DEBUGNAME("EV_INVUL_IMPACT");
;953:		CG_InvulnerabilityImpact( cent->lerpOrigin, cent->currentState.angles );
;954:		break;
;955:	case EV_JUICED:
;956:		DEBUGNAME("EV_JUICED");
;957:		CG_InvulnerabilityJuiced( cent->lerpOrigin );
;958:		break;
;959:	case EV_LIGHTNINGBOLT:
;960:		DEBUGNAME("EV_LIGHTNINGBOLT");
;961:		CG_LightningBoltBeam(es->origin2, es->pos.trBase);
;962:		break;
;963:#endif
;964:	case EV_SCOREPLUM:
;965:		DEBUGNAME("EV_SCOREPLUM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $707
ADDRGP4 $710
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $707
line 966
;966:		CG_ScorePlum( cent->currentState.otherEntityNum, cent->lerpOrigin, cent->currentState.time );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ScorePlum
CALLV
pop
line 967
;967:		break;
ADDRGP4 $339
JUMPV
LABELV $711
line 973
;968:
;969:	//
;970:	// missile impacts
;971:	//
;972:	case EV_MISSILE_HIT:
;973:		DEBUGNAME("EV_MISSILE_HIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $712
ADDRGP4 $715
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $712
line 974
;974:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 975
;975:		CG_MissileHitPlayer( es->weapon, position, dir, es->otherEntityNum );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitPlayer
CALLV
pop
line 976
;976:		break;
ADDRGP4 $339
JUMPV
LABELV $716
line 979
;977:
;978:	case EV_MISSILE_MISS:
;979:		DEBUGNAME("EV_MISSILE_MISS");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $717
ADDRGP4 $720
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $717
line 980
;980:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 981
;981:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_DEFAULT, qfalse );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 80
INDIRI4
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 982
;982:		break;
ADDRGP4 $339
JUMPV
LABELV $721
line 985
;983:
;984:	case EV_MISSILE_MISS_METAL:
;985:		DEBUGNAME("EV_MISSILE_MISS_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $722
ADDRGP4 $725
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $722
line 986
;986:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 987
;987:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_METAL, qfalse );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 988
;988:		break;
ADDRGP4 $339
JUMPV
LABELV $726
line 991
;989:
;990:	case EV_RAILTRAIL:
;991:		DEBUGNAME("EV_RAILTRAIL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $727
ADDRGP4 $730
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $727
line 992
;992:		cent->currentState.weapon = WP_RAILGUN;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 7
ASGNI4
line 994
;993:		// if the end was on a nomark surface, don't make an explosion
;994:		CG_RailTrail( ci, es->origin2, es->pos.trBase );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CG_RailTrail
CALLV
pop
line 995
;995:		if ( es->eventParm != 255 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 255
EQI4 $339
line 996
;996:			ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 997
;997:			CG_MissileHitWall( es->weapon, es->clientNum, position, dir, IMPACTSOUND_DEFAULT, qfalse );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 998
;998:		}
line 999
;999:		break;
ADDRGP4 $339
JUMPV
LABELV $733
line 1002
;1000:
;1001:	case EV_BULLET_HIT_WALL:
;1002:		DEBUGNAME("EV_BULLET_HIT_WALL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $734
ADDRGP4 $737
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $734
line 1003
;1003:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1004
;1004:		CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qfalse, ENTITYNUM_WORLD );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1022
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1005
;1005:		break;
ADDRGP4 $339
JUMPV
LABELV $738
line 1008
;1006:
;1007:	case EV_BULLET_HIT_FLESH:
;1008:		DEBUGNAME("EV_BULLET_HIT_FLESH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $739
ADDRGP4 $742
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $739
line 1009
;1009:		CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qtrue, es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1010
;1010:		break;
ADDRGP4 $339
JUMPV
LABELV $743
line 1013
;1011:
;1012:	case EV_SHOTGUN:
;1013:		DEBUGNAME("EV_SHOTGUN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $744
ADDRGP4 $747
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $744
line 1014
;1014:		CG_ShotgunFire( es, qfalse );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_ShotgunFire
CALLV
pop
line 1015
;1015:		break;
ADDRGP4 $339
JUMPV
LABELV $748
line 1018
;1016:
;1017:	case EV_EXPSHOTGUN:
;1018:		DEBUGNAME("EV_EXPSHOTGUN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $749
ADDRGP4 $752
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $749
line 1019
;1019:		CG_ShotgunFire(es, qtrue);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_ShotgunFire
CALLV
pop
line 1020
;1020:		break;
ADDRGP4 $339
JUMPV
LABELV $753
line 1023
;1021:
;1022:	case EV_GENERAL_SOUND:
;1023:		DEBUGNAME("EV_GENERAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $754
ADDRGP4 $757
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $754
line 1024
;1024:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35848
ADDP4
INDIRI4
CNSTI4 0
EQI4 $758
line 1025
;1025:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35848
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1026
;1026:		} else {
ADDRGP4 $339
JUMPV
LABELV $758
line 1027
;1027:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 100
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 100
INDIRP4
ASGNP4
line 1028
;1028:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1029
;1029:		}
line 1030
;1030:		break;
ADDRGP4 $339
JUMPV
LABELV $762
line 1033
;1031:
;1032:	case EV_GLOBAL_SOUND:	// play from the player's head so it never diminishes
;1033:		DEBUGNAME("EV_GLOBAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $763
ADDRGP4 $766
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $763
line 1034
;1034:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35848
ADDP4
INDIRI4
CNSTI4 0
EQI4 $767
line 1035
;1035:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRLP4 100
CNSTI4 184
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35848
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1036
;1036:		} else {
ADDRGP4 $339
JUMPV
LABELV $767
line 1037
;1037:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 100
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 100
INDIRP4
ASGNP4
line 1038
;1038:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1039
;1039:		}
line 1040
;1040:		break;
ADDRGP4 $339
JUMPV
LABELV $773
line 1043
;1041:
;1042:	case EV_GLOBAL_TEAM_SOUND:	// play from the player's head so it never diminishes
;1043:		{
line 1044
;1044:			DEBUGNAME("EV_GLOBAL_TEAM_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $774
ADDRGP4 $777
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $774
line 1045
;1045:			switch( es->eventParm ) {
ADDRLP4 100
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
LTI4 $339
ADDRLP4 100
INDIRI4
CNSTI4 12
GTI4 $339
ADDRLP4 100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $896
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $896
address $781
address $791
address $801
address $813
address $825
address $845
address $865
address $873
address $881
address $884
address $887
address $890
address $893
code
LABELV $781
line 1047
;1046:				case GTS_RED_CAPTURE: // CTF: red team captured the blue flag, 1FCTF: red team captured the neutral flag
;1047:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED )
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $782
line 1048
;1048:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+152340+952
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $339
JUMPV
LABELV $782
line 1050
;1049:					else
;1050:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+152340+956
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1051
;1051:					break;
ADDRGP4 $339
JUMPV
LABELV $791
line 1053
;1052:				case GTS_BLUE_CAPTURE: // CTF: blue team captured the red flag, 1FCTF: blue team captured the neutral flag
;1053:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_BLUE )
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $792
line 1054
;1054:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+152340+952
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $339
JUMPV
LABELV $792
line 1056
;1055:					else
;1056:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+152340+956
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1057
;1057:					break;
ADDRGP4 $339
JUMPV
LABELV $801
line 1059
;1058:				case GTS_RED_RETURN: // CTF: blue flag returned, 1FCTF: never used
;1059:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED )
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $802
line 1060
;1060:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+152340+960
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $803
JUMPV
LABELV $802
line 1062
;1061:					else
;1062:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+152340+964
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $803
line 1064
;1063:					//
;1064:					CG_AddBufferedSound( cgs.media.blueFlagReturnedSound );
ADDRGP4 cgs+152340+980
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1065
;1065:					break;
ADDRGP4 $339
JUMPV
LABELV $813
line 1067
;1066:				case GTS_BLUE_RETURN: // CTF red flag returned, 1FCTF: neutral flag returned
;1067:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_BLUE )
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $814
line 1068
;1068:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+152340+960
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $815
JUMPV
LABELV $814
line 1070
;1069:					else
;1070:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+152340+964
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $815
line 1072
;1071:					//
;1072:					CG_AddBufferedSound( cgs.media.redFlagReturnedSound );
ADDRGP4 cgs+152340+976
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1073
;1073:					break;
ADDRGP4 $339
JUMPV
LABELV $825
line 1077
;1074:
;1075:				case GTS_RED_TAKEN: // CTF: red team took blue flag, 1FCTF: blue team took the neutral flag
;1076:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1077:					if (cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
NEI4 $830
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
EQI4 $826
LABELV $830
line 1078
;1078:					}
ADDRGP4 $339
JUMPV
LABELV $826
line 1079
;1079:					else {
line 1080
;1080:					if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $831
line 1086
;1081:#ifdef MISSIONPACK
;1082:							if (cgs.gametype == GT_1FCTF) 
;1083:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
;1084:							else
;1085:#endif
;1086:						 	CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+152340+988
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1087
;1087:						}
ADDRGP4 $339
JUMPV
LABELV $831
line 1088
;1088:						else if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $339
line 1094
;1089:#ifdef MISSIONPACK
;1090:							if (cgs.gametype == GT_1FCTF)
;1091:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
;1092:							else
;1093:#endif
;1094: 							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+152340+996
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1095
;1095:						}
line 1096
;1096:					}
line 1097
;1097:					break;
ADDRGP4 $339
JUMPV
LABELV $845
line 1100
;1098:				case GTS_BLUE_TAKEN: // CTF: blue team took the red flag, 1FCTF red team took the neutral flag
;1099:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1100:					if (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRLP4 112
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
ADDRLP4 112
INDIRI4
NEI4 $850
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
ADDRLP4 112
INDIRI4
EQI4 $846
LABELV $850
line 1101
;1101:					}
ADDRGP4 $339
JUMPV
LABELV $846
line 1102
;1102:					else {
line 1103
;1103:						if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $851
line 1109
;1104:#ifdef MISSIONPACK
;1105:							if (cgs.gametype == GT_1FCTF)
;1106:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
;1107:							else
;1108:#endif
;1109:							CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+152340+988
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1110
;1110:						}
ADDRGP4 $339
JUMPV
LABELV $851
line 1111
;1111:						else if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $339
line 1117
;1112:#ifdef MISSIONPACK
;1113:							if (cgs.gametype == GT_1FCTF)
;1114:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
;1115:							else
;1116:#endif
;1117:							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+152340+996
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1118
;1118:						}
line 1119
;1119:					}
line 1120
;1120:					break;
ADDRGP4 $339
JUMPV
LABELV $865
line 1122
;1121:				case GTS_REDOBELISK_ATTACKED: // Overload: red obelisk is being attacked
;1122:					if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $339
line 1123
;1123:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
ADDRGP4 cgs+152340+1008
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1124
;1124:					}
line 1125
;1125:					break;
ADDRGP4 $339
JUMPV
LABELV $873
line 1127
;1126:				case GTS_BLUEOBELISK_ATTACKED: // Overload: blue obelisk is being attacked
;1127:					if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
CNSTI4 1708
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $339
line 1128
;1128:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
ADDRGP4 cgs+152340+1008
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1129
;1129:					}
line 1130
;1130:					break;
ADDRGP4 $339
JUMPV
LABELV $881
line 1133
;1131:
;1132:				case GTS_REDTEAM_SCORED:
;1133:					CG_AddBufferedSound(cgs.media.redScoredSound);
ADDRGP4 cgs+152340+932
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1134
;1134:					break;
ADDRGP4 $339
JUMPV
LABELV $884
line 1136
;1135:				case GTS_BLUETEAM_SCORED:
;1136:					CG_AddBufferedSound(cgs.media.blueScoredSound);
ADDRGP4 cgs+152340+936
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1137
;1137:					break;
ADDRGP4 $339
JUMPV
LABELV $887
line 1139
;1138:				case GTS_REDTEAM_TOOK_LEAD:
;1139:					CG_AddBufferedSound(cgs.media.redLeadsSound);
ADDRGP4 cgs+152340+940
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1140
;1140:					break;
ADDRGP4 $339
JUMPV
LABELV $890
line 1142
;1141:				case GTS_BLUETEAM_TOOK_LEAD:
;1142:					CG_AddBufferedSound(cgs.media.blueLeadsSound);
ADDRGP4 cgs+152340+944
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1143
;1143:					break;
ADDRGP4 $339
JUMPV
LABELV $893
line 1145
;1144:				case GTS_TEAMS_ARE_TIED:
;1145:					CG_AddBufferedSound( cgs.media.teamsTiedSound );
ADDRGP4 cgs+152340+948
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1146
;1146:					break;
line 1153
;1147:#ifdef MISSIONPACK
;1148:				case GTS_KAMIKAZE:
;1149:					trap_S_StartLocalSound(cgs.media.kamikazeFarSound, CHAN_ANNOUNCER);
;1150:					break;
;1151:#endif
;1152:				default:
;1153:					break;
line 1155
;1154:			}
;1155:			break;
ADDRGP4 $339
JUMPV
LABELV $897
line 1161
;1156:		}
;1157:
;1158:	case EV_PAIN:
;1159:		// local player sounds are triggered in CG_CheckLocalSounds,
;1160:		// so ignore events on the player
;1161:		DEBUGNAME("EV_PAIN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $898
ADDRGP4 $901
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $898
line 1162
;1162:		if ( cent->currentState.number != cg.snap->ps.clientNum ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $339
line 1163
;1163:			CG_PainEvent( cent, es->eventParm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 1164
;1164:		}
line 1165
;1165:		break;
ADDRGP4 $339
JUMPV
LABELV $905
line 1170
;1166:
;1167:	case EV_DEATH1:
;1168:	case EV_DEATH2:
;1169:	case EV_DEATH3:
;1170:		DEBUGNAME("EV_DEATHx");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $906
ADDRGP4 $909
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $906
line 1171
;1171:		trap_S_StartSound( NULL, es->number, CHAN_VOICE, 
ADDRGP4 $910
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 74
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 100
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1173
;1172:				CG_CustomSound( es->number, va("*death%i.wav", event - EV_DEATH1 + 1) ) );
;1173:		break;
ADDRGP4 $339
JUMPV
LABELV $911
line 1177
;1174:
;1175:
;1176:	case EV_OBITUARY:
;1177:		DEBUGNAME("EV_OBITUARY");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $912
ADDRGP4 $915
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $912
line 1178
;1178:		CG_Obituary( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Obituary
CALLV
pop
line 1179
;1179:		break;
ADDRGP4 $339
JUMPV
LABELV $916
line 1185
;1180:
;1181:	//
;1182:	// powerup events
;1183:	//
;1184:	case EV_POWERUP_QUAD:
;1185:		DEBUGNAME("EV_POWERUP_QUAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $917
ADDRGP4 $920
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $917
line 1186
;1186:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $921
line 1187
;1187:			cg.powerupActive = PW_QUAD;
ADDRGP4 cg+128524
CNSTI4 1
ASGNI4
line 1188
;1188:			cg.powerupTime = cg.time;
ADDRGP4 cg+128528
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 1189
;1189:		}
LABELV $921
line 1190
;1190:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.quadSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+152340+580
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1191
;1191:		break;
ADDRGP4 $339
JUMPV
LABELV $929
line 1193
;1192:	case EV_POWERUP_BATTLESUIT:
;1193:		DEBUGNAME("EV_POWERUP_BATTLESUIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $930
ADDRGP4 $933
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $930
line 1194
;1194:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $934
line 1195
;1195:			cg.powerupActive = PW_BATTLESUIT;
ADDRGP4 cg+128524
CNSTI4 2
ASGNI4
line 1196
;1196:			cg.powerupTime = cg.time;
ADDRGP4 cg+128528
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 1197
;1197:		}
LABELV $934
line 1198
;1198:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.protectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+152340+1052
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1199
;1199:		break;
ADDRGP4 $339
JUMPV
LABELV $942
line 1201
;1200:	case EV_POWERUP_REGEN:
;1201:		DEBUGNAME("EV_POWERUP_REGEN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $943
ADDRGP4 $946
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $943
line 1202
;1202:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $947
line 1203
;1203:			cg.powerupActive = PW_REGEN;
ADDRGP4 cg+128524
CNSTI4 5
ASGNI4
line 1204
;1204:			cg.powerupTime = cg.time;
ADDRGP4 cg+128528
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 1205
;1205:		}
LABELV $947
line 1206
;1206:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.regenSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+152340+1048
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1207
;1207:		break;
ADDRGP4 $339
JUMPV
LABELV $955
line 1209
;1208:	case EV_POWERUP_CONSERVATION:
;1209:		DEBUGNAME("EV_POWERUP_CONSERVATION");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $956
ADDRGP4 $959
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $956
line 1210
;1210:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $339
line 1211
;1211:			cg.powerupActive = PW_CONSERVATION;
ADDRGP4 cg+128524
CNSTI4 10
ASGNI4
line 1212
;1212:			cg.powerupTime = cg.time;
ADDRGP4 cg+128528
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 1213
;1213:		}
line 1214
;1214:		break;
ADDRGP4 $339
JUMPV
LABELV $966
line 1217
;1215:
;1216:	case EV_GIB_PLAYER:
;1217:		DEBUGNAME("EV_GIB_PLAYER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $967
ADDRGP4 $970
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $967
line 1221
;1218:		// don't play gib sound when using the kamikaze because it interferes
;1219:		// with the kamikaze sound, downside is that the gib sound will also
;1220:		// not be played when someone is gibbed while just carrying the kamikaze
;1221:		if ( !(es->eFlags & EF_KAMIKAZE) ) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $971
line 1222
;1222:			trap_S_StartSound( NULL, es->number, CHAN_BODY, cgs.media.gibSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+152340+748
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1223
;1223:		}
LABELV $971
line 1224
;1224:		CG_GibPlayer( cent->lerpOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_GibPlayer
CALLV
pop
line 1225
;1225:		break;
ADDRGP4 $339
JUMPV
LABELV $975
line 1228
;1226:
;1227:	case EV_STOPLOOPINGSOUND:
;1228:		DEBUGNAME("EV_STOPLOOPINGSOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $976
ADDRGP4 $979
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $976
line 1229
;1229:		trap_S_StopLoopingSound( es->number );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 1230
;1230:		es->loopSound = 0;
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1231
;1231:		break;
ADDRGP4 $339
JUMPV
LABELV $980
line 1234
;1232:
;1233:	case EV_DEBUG_LINE:
;1234:		DEBUGNAME("EV_DEBUG_LINE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $981
ADDRGP4 $984
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $981
line 1235
;1235:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1236
;1236:		break;
ADDRGP4 $339
JUMPV
LABELV $985
line 1239
;1237:
;1238:	case EV_EXPSHOTGUN_PICKUP:
;1239:		DEBUGNAME("EF_EXPSHOTGUN_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $986
ADDRGP4 $989
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $986
line 1240
;1240:		cg.snap->uberSGUsers[cent->currentState.clientNum] = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 54032
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 1241
;1241:		break;
ADDRGP4 $339
JUMPV
LABELV $991
line 1244
;1242:
;1243:	case EV_EXPSHOTGUN_DROP:
;1244:		DEBUGNAME("EF_EXPSHOTGUN_DROP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $992
ADDRGP4 $995
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $992
line 1245
;1245:		cg.snap->uberSGUsers[cent->currentState.clientNum] = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 54032
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 1246
;1246:		break;
ADDRGP4 $339
JUMPV
LABELV $997
line 1249
;1247:	
;1248:	case EV_MULTIGRENADE_PICKUP:
;1249:		DEBUGNAME("EF_MULTIGRENADE_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $998
ADDRGP4 $1001
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $998
line 1250
;1250:		cg.snap->uberGLUsers[cent->currentState.clientNum] = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 54288
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 1251
;1251:		break;
ADDRGP4 $339
JUMPV
LABELV $1003
line 1254
;1252:
;1253:	case EV_MULTIGRENADE_DROP:
;1254:		DEBUGNAME("EF_MULTIGRENADE_DROP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1004
ADDRGP4 $1007
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1004
line 1255
;1255:		cg.snap->uberGLUsers[cent->currentState.clientNum] = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 54288
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 1256
;1256:		break;
ADDRGP4 $339
JUMPV
LABELV $1009
line 1259
;1257:
;1258:	case EV_HOMINGROCKET_PICKUP:
;1259:		DEBUGNAME("EF_HOMINGROCKET_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1010
ADDRGP4 $1013
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1010
line 1260
;1260:		cg.snap->uberRLUsers[cent->currentState.clientNum] = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 54544
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 1261
;1261:		break;
ADDRGP4 $339
JUMPV
LABELV $1015
line 1264
;1262:
;1263:	case EV_HOMINGROCKET_DROP:
;1264:		DEBUGNAME("EF_HOMINGROCKET_DROP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1016
ADDRGP4 $1019
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1016
line 1265
;1265:		cg.snap->uberRLUsers[cent->currentState.clientNum] = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 54544
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 1266
;1266:		break;
ADDRGP4 $339
JUMPV
LABELV $1021
line 1269
;1267:
;1268:	case EV_ARCLIGHTNING_PICKUP:
;1269:		DEBUGNAME("EF_ARCLIGHTNING_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $339
ADDRGP4 $1025
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1271
;1270:		//cent->uberState |= UBER_LIGHTNING_ORB;
;1271:		break;
ADDRGP4 $339
JUMPV
LABELV $1026
line 1274
;1272:
;1273:	case EV_IONPLASMA_PICKUP:
;1274:		DEBUGNAME("EF_IONPLASMA_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $339
ADDRGP4 $1030
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1276
;1275:		//cent->uberState |= UBER_PLASMA_ORB;
;1276:		break;
ADDRGP4 $339
JUMPV
LABELV $1031
line 1279
;1277:
;1278:	case EV_TOXICRAIL_PICKUP:
;1279:		DEBUGNAME("EF_TOXICRAIL_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $339
ADDRGP4 $1035
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1281
;1280:		//cent->uberState |= UBER_RAIL_ORB;
;1281:		break;
ADDRGP4 $339
JUMPV
LABELV $1036
line 1284
;1282:
;1283:	case EV_BFG30K_PICKUP:
;1284:		DEBUGNAME("EF_BFG30K_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $339
ADDRGP4 $1040
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1286
;1285:		//cent->uberState |= UBER_BFG_ORB;
;1286:		break;
ADDRGP4 $339
JUMPV
LABELV $338
line 1290
;1287:		
;1288:
;1289:	default:
;1290:		DEBUGNAME("UNKNOWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1041
ADDRGP4 $1044
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1041
line 1291
;1291:		CG_Error( "Unknown event: %i", event );
ADDRGP4 $1045
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1292
;1292:		break;
LABELV $339
line 1295
;1293:	}
;1294:
;1295:}
LABELV $323
endproc CG_EntityEvent 116 48
export CG_CheckEvents
proc CG_CheckEvents 8 12
line 1304
;1296:
;1297:
;1298:/*
;1299:==============
;1300:CG_CheckEvents
;1301:
;1302:==============
;1303:*/
;1304:void CG_CheckEvents( centity_t *cent ) {
line 1306
;1305:	// check for event-only entities
;1306:	if ( cent->currentState.eType > ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 14
LEI4 $1049
line 1307
;1307:		if ( cent->previousEvent ) {
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1051
line 1308
;1308:			return;	// already fired
ADDRGP4 $1048
JUMPV
LABELV $1051
line 1311
;1309:		}
;1310:		// if this is a player event set the entity number of the client entity number
;1311:		if ( cent->currentState.eFlags & EF_PLAYER_EVENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1053
line 1312
;1312:			cent->currentState.number = cent->currentState.otherEntityNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 1313
;1313:		}
LABELV $1053
line 1315
;1314:
;1315:		cent->previousEvent = 1;
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTI4 1
ASGNI4
line 1317
;1316:
;1317:		cent->currentState.event = cent->currentState.eType - ET_EVENTS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 14
SUBI4
ASGNI4
line 1318
;1318:	} else {
ADDRGP4 $1050
JUMPV
LABELV $1049
line 1320
;1319:		// check for events riding with another entity
;1320:		if ( cent->currentState.event == cent->previousEvent ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
NEI4 $1055
line 1321
;1321:			return;
ADDRGP4 $1048
JUMPV
LABELV $1055
line 1323
;1322:		}
;1323:		cent->previousEvent = cent->currentState.event;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1324
;1324:		if ( ( cent->currentState.event & ~EV_EVENT_BITS ) == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 0
NEI4 $1057
line 1325
;1325:			return;
ADDRGP4 $1048
JUMPV
LABELV $1057
line 1327
;1326:		}
;1327:	}
LABELV $1050
line 1330
;1328:
;1329:	// calculate the position at exactly the frame time
;1330:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, cent->lerpOrigin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1331
;1331:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 1333
;1332:
;1333:	CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 1334
;1334:}
LABELV $1048
endproc CG_CheckEvents 8 12
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedBoxTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_AddCommand
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_ShaderStateChanged
import CG_LoadVoiceChats
import CG_SetConfigValues
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_InitConsoleCommands
import CG_ConsoleCommand
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayer
import CG_ScorePlum
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawSmallStringColor
import CG_DrawSmallString
import CG_DrawBigStringColor
import CG_DrawBigString
import CG_DrawStringExt
import CG_DrawString
import CG_DrawPic
import CG_FillRect
import CG_AdjustFrom640
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_BuildSpectatorString
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import cg_UpsideDown
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_oldRail
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_cameraMode
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import pmove_msec
import pmove_fixed
import cg_smoothClients
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_synchronousClients
import cg_drawAttacker
import cg_lagometer
import cg_stereoSeparation
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_ignore
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_brassTime
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_railTrailTime
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $1045
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1044
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $1040
byte 1 69
byte 1 70
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 51
byte 1 48
byte 1 75
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $1035
byte 1 69
byte 1 70
byte 1 95
byte 1 84
byte 1 79
byte 1 88
byte 1 73
byte 1 67
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $1030
byte 1 69
byte 1 70
byte 1 95
byte 1 73
byte 1 79
byte 1 78
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $1025
byte 1 69
byte 1 70
byte 1 95
byte 1 65
byte 1 82
byte 1 67
byte 1 76
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $1019
byte 1 69
byte 1 70
byte 1 95
byte 1 72
byte 1 79
byte 1 77
byte 1 73
byte 1 78
byte 1 71
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 68
byte 1 82
byte 1 79
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $1013
byte 1 69
byte 1 70
byte 1 95
byte 1 72
byte 1 79
byte 1 77
byte 1 73
byte 1 78
byte 1 71
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $1007
byte 1 69
byte 1 70
byte 1 95
byte 1 77
byte 1 85
byte 1 76
byte 1 84
byte 1 73
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 68
byte 1 82
byte 1 79
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $1001
byte 1 69
byte 1 70
byte 1 95
byte 1 77
byte 1 85
byte 1 76
byte 1 84
byte 1 73
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $995
byte 1 69
byte 1 70
byte 1 95
byte 1 69
byte 1 88
byte 1 80
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 95
byte 1 68
byte 1 82
byte 1 79
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $989
byte 1 69
byte 1 70
byte 1 95
byte 1 69
byte 1 88
byte 1 80
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $984
byte 1 69
byte 1 86
byte 1 95
byte 1 68
byte 1 69
byte 1 66
byte 1 85
byte 1 71
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $979
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 84
byte 1 79
byte 1 80
byte 1 76
byte 1 79
byte 1 79
byte 1 80
byte 1 73
byte 1 78
byte 1 71
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $970
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 73
byte 1 66
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $959
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 67
byte 1 79
byte 1 78
byte 1 83
byte 1 69
byte 1 82
byte 1 86
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $946
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 82
byte 1 69
byte 1 71
byte 1 69
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $933
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 66
byte 1 65
byte 1 84
byte 1 84
byte 1 76
byte 1 69
byte 1 83
byte 1 85
byte 1 73
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $920
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 81
byte 1 85
byte 1 65
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $915
byte 1 69
byte 1 86
byte 1 95
byte 1 79
byte 1 66
byte 1 73
byte 1 84
byte 1 85
byte 1 65
byte 1 82
byte 1 89
byte 1 10
byte 1 0
align 1
LABELV $910
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $909
byte 1 69
byte 1 86
byte 1 95
byte 1 68
byte 1 69
byte 1 65
byte 1 84
byte 1 72
byte 1 120
byte 1 10
byte 1 0
align 1
LABELV $901
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 65
byte 1 73
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $777
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $766
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $757
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $752
byte 1 69
byte 1 86
byte 1 95
byte 1 69
byte 1 88
byte 1 80
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $747
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $742
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 85
byte 1 76
byte 1 76
byte 1 69
byte 1 84
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 95
byte 1 70
byte 1 76
byte 1 69
byte 1 83
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $737
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 85
byte 1 76
byte 1 76
byte 1 69
byte 1 84
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 95
byte 1 87
byte 1 65
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $730
byte 1 69
byte 1 86
byte 1 95
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 84
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $725
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 95
byte 1 77
byte 1 69
byte 1 84
byte 1 65
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $720
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 10
byte 1 0
align 1
LABELV $715
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $710
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 67
byte 1 79
byte 1 82
byte 1 69
byte 1 80
byte 1 76
byte 1 85
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $699
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 79
byte 1 78
byte 1 95
byte 1 66
byte 1 79
byte 1 85
byte 1 78
byte 1 67
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $688
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 66
byte 1 79
byte 1 85
byte 1 78
byte 1 67
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $680
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 82
byte 1 69
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $673
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 79
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $666
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 95
byte 1 79
byte 1 85
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $659
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 95
byte 1 73
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $654
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 52
byte 1 10
byte 1 0
align 1
LABELV $649
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $644
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $639
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $634
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $629
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 57
byte 1 10
byte 1 0
align 1
LABELV $624
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 56
byte 1 10
byte 1 0
align 1
LABELV $619
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 55
byte 1 10
byte 1 0
align 1
LABELV $614
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 54
byte 1 10
byte 1 0
align 1
LABELV $609
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 53
byte 1 10
byte 1 0
align 1
LABELV $604
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 52
byte 1 10
byte 1 0
align 1
LABELV $599
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $594
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $589
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $584
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $579
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $572
byte 1 69
byte 1 86
byte 1 95
byte 1 67
byte 1 72
byte 1 65
byte 1 78
byte 1 71
byte 1 69
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $564
byte 1 69
byte 1 86
byte 1 95
byte 1 78
byte 1 79
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 10
byte 1 0
align 1
LABELV $550
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $532
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $527
byte 1 42
byte 1 103
byte 1 97
byte 1 115
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $526
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 67
byte 1 76
byte 1 69
byte 1 65
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $519
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 85
byte 1 78
byte 1 68
byte 1 69
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $512
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 76
byte 1 69
byte 1 65
byte 1 86
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $505
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 79
byte 1 85
byte 1 67
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $500
byte 1 42
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $499
byte 1 69
byte 1 86
byte 1 95
byte 1 84
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $494
byte 1 69
byte 1 86
byte 1 95
byte 1 74
byte 1 85
byte 1 77
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $489
byte 1 42
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $482
byte 1 69
byte 1 86
byte 1 95
byte 1 74
byte 1 85
byte 1 77
byte 1 80
byte 1 95
byte 1 80
byte 1 65
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $452
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $439
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $438
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 70
byte 1 65
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $426
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 77
byte 1 69
byte 1 68
byte 1 73
byte 1 85
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $412
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 79
byte 1 85
byte 1 78
byte 1 67
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $398
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 82
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $387
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 87
byte 1 73
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $376
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 87
byte 1 65
byte 1 68
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $365
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $354
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 95
byte 1 77
byte 1 69
byte 1 84
byte 1 65
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $344
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $333
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 69
byte 1 86
byte 1 69
byte 1 78
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $327
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $321
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 49
byte 1 48
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $320
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 55
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $317
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 53
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $314
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 50
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $273
byte 1 85
byte 1 115
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $272
byte 1 78
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $262
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $261
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $256
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $255
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $254
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $252
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 105
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 0
align 1
LABELV $249
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 111
byte 1 110
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $246
byte 1 39
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 99
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $245
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 117
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 0
align 1
LABELV $243
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 106
byte 1 111
byte 1 108
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $240
byte 1 39
byte 1 115
byte 1 32
byte 1 104
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $239
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 104
byte 1 117
byte 1 110
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $236
byte 1 39
byte 1 115
byte 1 32
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $235
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 121
byte 1 32
byte 1 97
byte 1 119
byte 1 97
byte 1 121
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $232
byte 1 39
byte 1 115
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $231
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $229
byte 1 39
byte 1 115
byte 1 32
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $228
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $226
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 114
byte 1 111
byte 1 99
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $224
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $221
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $220
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $218
byte 1 97
byte 1 108
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 100
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $216
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $214
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $213
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 101
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $211
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $210
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $208
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $206
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $204
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 109
byte 1 109
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $202
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $191
byte 1 110
byte 1 111
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $188
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $185
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $178
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $174
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $173
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $170
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $167
byte 1 115
byte 1 104
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $165
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $164
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $161
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $157
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $156
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $153
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $149
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $148
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $145
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $135
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 114
byte 1 111
byte 1 110
byte 1 103
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $133
byte 1 115
byte 1 97
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $131
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 0
align 1
LABELV $129
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $127
byte 1 115
byte 1 97
byte 1 110
byte 1 107
byte 1 32
byte 1 108
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $125
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 113
byte 1 117
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $123
byte 1 99
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $121
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $117
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $116
byte 1 110
byte 1 0
align 1
LABELV $109
byte 1 67
byte 1 71
byte 1 95
byte 1 79
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 58
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $104
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $103
byte 1 37
byte 1 105
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $102
byte 1 37
byte 1 105
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $99
byte 1 37
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $96
byte 1 37
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $93
byte 1 49
byte 1 51
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $90
byte 1 49
byte 1 50
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $87
byte 1 49
byte 1 49
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $84
byte 1 94
byte 1 51
byte 1 51
byte 1 114
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $81
byte 1 94
byte 1 49
byte 1 50
byte 1 110
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $78
byte 1 94
byte 1 52
byte 1 49
byte 1 115
byte 1 116
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $75
byte 1 0
align 1
LABELV $74
byte 1 84
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 0
