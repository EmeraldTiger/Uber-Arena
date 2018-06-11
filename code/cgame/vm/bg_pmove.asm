data
export pm_stopspeed
align 4
LABELV pm_stopspeed
byte 4 1120403456
export pm_duckScale
align 4
LABELV pm_duckScale
byte 4 1048576000
export pm_swimScale
align 4
LABELV pm_swimScale
byte 4 1056964608
export pm_wadeScale
align 4
LABELV pm_wadeScale
byte 4 1060320051
export pm_accelerate
align 4
LABELV pm_accelerate
byte 4 1092616192
export pm_airaccelerate
align 4
LABELV pm_airaccelerate
byte 4 1065353216
export pm_wateraccelerate
align 4
LABELV pm_wateraccelerate
byte 4 1082130432
export pm_flyaccelerate
align 4
LABELV pm_flyaccelerate
byte 4 1090519040
export pm_friction
align 4
LABELV pm_friction
byte 4 1086324736
export pm_waterfriction
align 4
LABELV pm_waterfriction
byte 4 1065353216
export pm_flightfriction
align 4
LABELV pm_flightfriction
byte 4 1077936128
export pm_spectatorfriction
align 4
LABELV pm_spectatorfriction
byte 4 1084227584
export c_pmove
align 4
LABELV c_pmove
byte 4 0
export PM_AddEvent
code
proc PM_AddEvent 0 12
file "../../game/bg_pmove.c"
line 58
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
;23:// bg_pmove.c -- both games player movement code
;24:// takes a playerstate and a usercmd as input and returns a modifed playerstate
;25:
;26:#include "q_shared.h"
;27:#include "bg_public.h"
;28:#include "bg_local.h"
;29:
;30:pmove_t		*pm;
;31:pml_t		pml;
;32:
;33:// movement parameters
;34:float	pm_stopspeed = 100.0f;
;35:float	pm_duckScale = 0.25f;
;36:float	pm_swimScale = 0.50f;
;37:float	pm_wadeScale = 0.70f;
;38:
;39:float	pm_accelerate = 10.0f;
;40:float	pm_airaccelerate = 1.0f;
;41:float	pm_wateraccelerate = 4.0f;
;42:float	pm_flyaccelerate = 8.0f;
;43:
;44:float	pm_friction = 6.0f;
;45:float	pm_waterfriction = 1.0f;
;46:float	pm_flightfriction = 3.0f;
;47:float	pm_spectatorfriction = 5.0f;
;48:
;49:int		c_pmove = 0;
;50:
;51:
;52:/*
;53:===============
;54:PM_AddEvent
;55:
;56:===============
;57:*/
;58:void PM_AddEvent( int newEvent ) {
line 59
;59:	BG_AddPredictableEventToPlayerstate( newEvent, 0, pm->ps );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 pm
INDIRP4
INDIRP4
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 60
;60:}
LABELV $41
endproc PM_AddEvent 0 12
export PM_AddTouchEnt
proc PM_AddTouchEnt 12 0
line 67
;61:
;62:/*
;63:===============
;64:PM_AddTouchEnt
;65:===============
;66:*/
;67:void PM_AddTouchEnt( int entityNum ) {
line 70
;68:	int		i;
;69:
;70:	if ( entityNum == ENTITYNUM_WORLD ) {
ADDRFP4 0
INDIRI4
CNSTI4 1022
NEI4 $43
line 71
;71:		return;
ADDRGP4 $42
JUMPV
LABELV $43
line 73
;72:	}
;73:	if ( pm->numtouch == MAXTOUCH ) {
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 32
NEI4 $45
line 74
;74:		return;
ADDRGP4 $42
JUMPV
LABELV $45
line 78
;75:	}
;76:
;77:	// see if it is already added
;78:	for ( i = 0 ; i < pm->numtouch ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $50
JUMPV
LABELV $47
line 79
;79:		if ( pm->touchents[ i ] == entityNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
CNSTI4 52
ADDP4
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $51
line 80
;80:			return;
ADDRGP4 $42
JUMPV
LABELV $51
line 82
;81:		}
;82:	}
LABELV $48
line 78
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $50
ADDRLP4 0
INDIRI4
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
LTI4 $47
line 85
;83:
;84:	// add it
;85:	pm->touchents[pm->numtouch] = entityNum;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 86
;86:	pm->numtouch++;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 87
;87:}
LABELV $42
endproc PM_AddTouchEnt 12 0
proc PM_StartTorsoAnim 8 0
line 94
;88:
;89:/*
;90:===================
;91:PM_StartTorsoAnim
;92:===================
;93:*/
;94:static void PM_StartTorsoAnim( int anim ) {
line 95
;95:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $54
line 96
;96:		return;
ADDRGP4 $53
JUMPV
LABELV $54
line 98
;97:	}
;98:	pm->ps->torsoAnim = ( ( pm->ps->torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
ASGNP4
ADDRLP4 4
CNSTI4 128
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
ADDRLP4 4
INDIRI4
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 100
;99:		| anim;
;100:}
LABELV $53
endproc PM_StartTorsoAnim 8 0
proc PM_StartLegsAnim 8 0
line 101
;101:static void PM_StartLegsAnim( int anim ) {
line 102
;102:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $57
line 103
;103:		return;
ADDRGP4 $56
JUMPV
LABELV $57
line 105
;104:	}
;105:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $59
line 106
;106:		return;		// a high priority animation is running
ADDRGP4 $56
JUMPV
LABELV $59
line 108
;107:	}
;108:	pm->ps->legsAnim = ( ( pm->ps->legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 4
CNSTI4 128
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
ADDRLP4 4
INDIRI4
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 110
;109:		| anim;
;110:}
LABELV $56
endproc PM_StartLegsAnim 8 0
proc PM_ContinueLegsAnim 0 4
line 112
;111:
;112:static void PM_ContinueLegsAnim( int anim ) {
line 113
;113:	if ( ( pm->ps->legsAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $62
line 114
;114:		return;
ADDRGP4 $61
JUMPV
LABELV $62
line 116
;115:	}
;116:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $64
line 117
;117:		return;		// a high priority animation is running
ADDRGP4 $61
JUMPV
LABELV $64
line 119
;118:	}
;119:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 120
;120:}
LABELV $61
endproc PM_ContinueLegsAnim 0 4
proc PM_ContinueTorsoAnim 0 4
line 122
;121:
;122:static void PM_ContinueTorsoAnim( int anim ) {
line 123
;123:	if ( ( pm->ps->torsoAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $67
line 124
;124:		return;
ADDRGP4 $66
JUMPV
LABELV $67
line 126
;125:	}
;126:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $69
line 127
;127:		return;		// a high priority animation is running
ADDRGP4 $66
JUMPV
LABELV $69
line 129
;128:	}
;129:	PM_StartTorsoAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 130
;130:}
LABELV $66
endproc PM_ContinueTorsoAnim 0 4
proc PM_ForceLegsAnim 0 4
line 132
;131:
;132:static void PM_ForceLegsAnim( int anim ) {
line 133
;133:	pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 134
;134:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 135
;135:}
LABELV $71
endproc PM_ForceLegsAnim 0 4
export PM_ClipVelocity
proc PM_ClipVelocity 32 0
line 145
;136:
;137:
;138:/*
;139:==================
;140:PM_ClipVelocity
;141:
;142:Slide off of the impacting surface
;143:==================
;144:*/
;145:void PM_ClipVelocity( vec3_t in, vec3_t normal, vec3_t out, float overbounce ) {
line 150
;146:	float	backoff;
;147:	float	change;
;148:	int		i;
;149:	
;150:	backoff = DotProduct (in, normal);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 152
;151:	
;152:	if ( backoff < 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GEF4 $73
line 153
;153:		backoff *= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 154
;154:	} else {
ADDRGP4 $74
JUMPV
LABELV $73
line 155
;155:		backoff /= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
ASGNF4
line 156
;156:	}
LABELV $74
line 158
;157:
;158:	for ( i=0 ; i<3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $75
line 159
;159:		change = normal[i]*backoff;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 160
;160:		out[i] = in[i] - change;
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 28
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 161
;161:	}
LABELV $76
line 158
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $75
line 162
;162:}
LABELV $72
endproc PM_ClipVelocity 32 0
proc PM_Friction 48 4
line 172
;163:
;164:
;165:/*
;166:==================
;167:PM_Friction
;168:
;169:Handles both ground friction and water friction
;170:==================
;171:*/
;172:static void PM_Friction( void ) {
line 178
;173:	vec3_t	vec;
;174:	float	*vel;
;175:	float	speed, newspeed, control;
;176:	float	drop;
;177:	
;178:	vel = pm->ps->velocity;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
line 180
;179:	
;180:	VectorCopy( vel, vec );
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 12
line 181
;181:	if ( pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $80
line 182
;182:		vec[2] = 0;	// ignore slope movement
ADDRLP4 16+8
CNSTF4 0
ASGNF4
line 183
;183:	}
LABELV $80
line 185
;184:
;185:	speed = VectorLength(vec);
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 186
;186:	if (speed < 1) {
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
GEF4 $84
line 187
;187:		vel[0] = 0;
ADDRLP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 188
;188:		vel[1] = 0;		// allow sinking underwater
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 190
;189:		// FIXME: still have z friction underwater?
;190:		return;
ADDRGP4 $79
JUMPV
LABELV $84
line 193
;191:	}
;192:
;193:	drop = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 196
;194:
;195:	// apply ground friction
;196:	if ( pm->waterlevel <= 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
GTI4 $86
line 197
;197:		if ( pml.walking && !(pml.groundTrace.surfaceFlags & SURF_SLICK) ) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 pml+44
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $88
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 36
INDIRI4
NEI4 $88
line 199
;198:			// if getting knocked back, no friction
;199:			if ( ! (pm->ps->pm_flags & PMF_TIME_KNOCKBACK) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $93
line 200
;200:				control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 8
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $96
ADDRLP4 40
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $97
JUMPV
LABELV $96
ADDRLP4 40
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $97
ADDRLP4 28
ADDRLP4 40
INDIRF4
ASGNF4
line 201
;201:				drop += control*pm_friction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
ADDRGP4 pm_friction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 202
;202:			}
LABELV $93
line 203
;203:		}
LABELV $88
line 204
;204:	}
LABELV $86
line 207
;205:
;206:	// apply water friction even if just wading
;207:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
EQI4 $99
line 208
;208:		drop += speed*pm_waterfriction*pm->waterlevel*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_waterfriction
INDIRF4
MULF4
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 209
;209:	}
LABELV $99
line 212
;210:
;211:	// apply flying friction
;212:	if ( pm->ps->powerups[PW_FLIGHT]) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $102
line 213
;213:		drop += speed*pm_flightfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_flightfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 214
;214:	}
LABELV $102
line 216
;215:
;216:	if ( pm->ps->pm_type == PM_SPECTATOR) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $105
line 217
;217:		drop += speed*pm_spectatorfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_spectatorfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 218
;218:	}
LABELV $105
line 221
;219:
;220:	// scale the velocity
;221:	newspeed = speed - drop;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 222
;222:	if (newspeed < 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $108
line 223
;223:		newspeed = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 224
;224:	}
LABELV $108
line 225
;225:	newspeed /= speed;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 227
;226:
;227:	vel[0] = vel[0] * newspeed;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 228
;228:	vel[1] = vel[1] * newspeed;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 229
;229:	vel[2] = vel[2] * newspeed;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 230
;230:}
LABELV $79
endproc PM_Friction 48 4
proc PM_Accelerate 32 0
line 240
;231:
;232:
;233:/*
;234:==============
;235:PM_Accelerate
;236:
;237:Handles user intended acceleration
;238:==============
;239:*/
;240:static void PM_Accelerate( vec3_t wishdir, float wishspeed, float accel ) {
line 246
;241:#if 1
;242:	// q2 style
;243:	int			i;
;244:	float		addspeed, accelspeed, currentspeed;
;245:
;246:	currentspeed = DotProduct (pm->ps->velocity, wishdir);
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 247
;247:	addspeed = wishspeed - currentspeed;
ADDRLP4 8
ADDRFP4 4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 248
;248:	if (addspeed <= 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $111
line 249
;249:		return;
ADDRGP4 $110
JUMPV
LABELV $111
line 251
;250:	}
;251:	accelspeed = accel*pml.frametime*wishspeed;
ADDRLP4 4
ADDRFP4 8
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 252
;252:	if (accelspeed > addspeed) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $114
line 253
;253:		accelspeed = addspeed;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 254
;254:	}
LABELV $114
line 256
;255:	
;256:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $116
line 257
;257:		pm->ps->velocity[i] += accelspeed*wishdir[i];	
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
ADDRLP4 24
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 258
;258:	}
LABELV $117
line 256
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $116
line 277
;259:#else
;260:	// proper way (avoids strafe jump maxspeed bug), but feels bad
;261:	vec3_t		wishVelocity;
;262:	vec3_t		pushDir;
;263:	float		pushLen;
;264:	float		canPush;
;265:
;266:	VectorScale( wishdir, wishspeed, wishVelocity );
;267:	VectorSubtract( wishVelocity, pm->ps->velocity, pushDir );
;268:	pushLen = VectorNormalize( pushDir );
;269:
;270:	canPush = accel*pml.frametime*wishspeed;
;271:	if (canPush > pushLen) {
;272:		canPush = pushLen;
;273:	}
;274:
;275:	VectorMA( pm->ps->velocity, canPush, pushDir, pm->ps->velocity );
;276:#endif
;277:}
LABELV $110
endproc PM_Accelerate 32 0
proc PM_CmdScale 44 4
line 290
;278:
;279:
;280:
;281:/*
;282:============
;283:PM_CmdScale
;284:
;285:Returns the scale factor to apply to cmd movements
;286:This allows the clients to use axial -127 to 127 values for all directions
;287:without getting a sqrt(2) distortion in speed.
;288:============
;289:*/
;290:static float PM_CmdScale( usercmd_t *cmd ) {
line 295
;291:	int		max;
;292:	float	total;
;293:	float	scale;
;294:
;295:	max = abs( cmd->forwardmove );
ADDRFP4 0
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 296
;296:	if ( abs( cmd->rightmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $121
line 297
;297:		max = abs( cmd->rightmove );
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 298
;298:	}
LABELV $121
line 299
;299:	if ( abs( cmd->upmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $123
line 300
;300:		max = abs( cmd->upmove );
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 24
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 301
;301:	}
LABELV $123
line 302
;302:	if ( !max ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $125
line 303
;303:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $120
JUMPV
LABELV $125
line 306
;304:	}
;305:
;306:	total = sqrt( cmd->forwardmove * cmd->forwardmove
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 36
ADDRLP4 24
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 28
INDIRI4
MULI4
ADDRLP4 32
INDIRI4
ADDRLP4 32
INDIRI4
MULI4
ADDI4
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
MULI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 40
INDIRF4
ASGNF4
line 308
;307:		+ cmd->rightmove * cmd->rightmove + cmd->upmove * cmd->upmove );
;308:	scale = (float)pm->ps->speed * max / ( 127.0 * total );
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CVIF4 4
MULF4
CNSTF4 1123942400
ADDRLP4 4
INDIRF4
MULF4
DIVF4
ASGNF4
line 310
;309:
;310:	return scale;
ADDRLP4 8
INDIRF4
RETF4
LABELV $120
endproc PM_CmdScale 44 4
proc PM_SetMovementDir 72 0
line 322
;311:}
;312:
;313:
;314:/*
;315:================
;316:PM_SetMovementDir
;317:
;318:Determine the rotation of the legs reletive
;319:to the facing dir
;320:================
;321:*/
;322:static void PM_SetMovementDir( void ) {
line 323
;323:	if ( pm->cmd.forwardmove || pm->cmd.rightmove ) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
NEI4 $130
ADDRLP4 0
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
EQI4 $128
LABELV $130
line 324
;324:		if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove > 0 ) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
NEI4 $131
ADDRLP4 8
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
LEI4 $131
line 325
;325:			pm->ps->movementDir = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 326
;326:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove > 0 ) {
ADDRGP4 $129
JUMPV
LABELV $131
ADDRLP4 16
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 20
INDIRI4
GEI4 $133
ADDRLP4 16
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 20
INDIRI4
LEI4 $133
line 327
;327:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 328
;328:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove == 0 ) {
ADDRGP4 $129
JUMPV
LABELV $133
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 28
INDIRI4
GEI4 $135
ADDRLP4 24
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 28
INDIRI4
NEI4 $135
line 329
;329:			pm->ps->movementDir = 2;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 2
ASGNI4
line 330
;330:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $129
JUMPV
LABELV $135
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
GEI4 $137
ADDRLP4 32
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
GEI4 $137
line 331
;331:			pm->ps->movementDir = 3;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 3
ASGNI4
line 332
;332:		} else if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $129
JUMPV
LABELV $137
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
NEI4 $139
ADDRLP4 40
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
GEI4 $139
line 333
;333:			pm->ps->movementDir = 4;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 4
ASGNI4
line 334
;334:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $129
JUMPV
LABELV $139
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
LEI4 $141
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
GEI4 $141
line 335
;335:			pm->ps->movementDir = 5;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 5
ASGNI4
line 336
;336:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove == 0 ) {
ADDRGP4 $129
JUMPV
LABELV $141
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 60
INDIRI4
LEI4 $143
ADDRLP4 56
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 60
INDIRI4
NEI4 $143
line 337
;337:			pm->ps->movementDir = 6;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 6
ASGNI4
line 338
;338:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove > 0 ) {
ADDRGP4 $129
JUMPV
LABELV $143
ADDRLP4 64
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 68
INDIRI4
LEI4 $129
ADDRLP4 64
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 68
INDIRI4
LEI4 $129
line 339
;339:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 340
;340:		}
line 341
;341:	} else {
ADDRGP4 $129
JUMPV
LABELV $128
line 345
;342:		// if they aren't actively going directly sideways,
;343:		// change the animation to the diagonal so they
;344:		// don't stop too crooked
;345:		if ( pm->ps->movementDir == 2 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 2
NEI4 $147
line 346
;346:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 347
;347:		} else if ( pm->ps->movementDir == 6 ) {
ADDRGP4 $148
JUMPV
LABELV $147
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 6
NEI4 $149
line 348
;348:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 349
;349:		} 
LABELV $149
LABELV $148
line 350
;350:	}
LABELV $129
line 351
;351:}
LABELV $127
endproc PM_SetMovementDir 72 0
proc PM_CheckJump 8 4
line 359
;352:
;353:
;354:/*
;355:=============
;356:PM_CheckJump
;357:=============
;358:*/
;359:static qboolean PM_CheckJump( void ) {
line 360
;360:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $152
line 361
;361:		return qfalse;		// don't allow jump until all buttons are up
CNSTI4 0
RETI4
ADDRGP4 $151
JUMPV
LABELV $152
line 364
;362:	}
;363:
;364:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $154
line 366
;365:		// not holding jump
;366:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $151
JUMPV
LABELV $154
line 370
;367:	}
;368:
;369:	// must wait for jump to be released
;370:	if ( pm->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $156
line 372
;371:		// clear upmove so cmdscale doesn't lower running speed
;372:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 373
;373:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $151
JUMPV
LABELV $156
line 376
;374:	}
;375:
;376:	pml.groundPlane = qfalse;		// jumping away
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 377
;377:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 378
;378:	pm->ps->pm_flags |= PMF_JUMP_HELD;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 380
;379:
;380:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 381
;381:	pm->ps->velocity[2] = JUMP_VELOCITY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1132920832
ASGNF4
line 382
;382:	PM_AddEvent( EV_JUMP );
CNSTI4 15
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 384
;383:
;384:	if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $160
line 385
;385:		PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 386
;386:		pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 387
;387:	} else {
ADDRGP4 $161
JUMPV
LABELV $160
line 388
;388:		PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 389
;389:		pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 390
;390:	}
LABELV $161
line 392
;391:
;392:	return qtrue;
CNSTI4 1
RETI4
LABELV $151
endproc PM_CheckJump 8 4
proc PM_CheckWaterJump 56 8
line 400
;393:}
;394:
;395:/*
;396:=============
;397:PM_CheckWaterJump
;398:=============
;399:*/
;400:static qboolean	PM_CheckWaterJump( void ) {
line 405
;401:	vec3_t	spot;
;402:	int		cont;
;403:	vec3_t	flatforward;
;404:
;405:	if (pm->ps->pm_time) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $163
line 406
;406:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $162
JUMPV
LABELV $163
line 410
;407:	}
;408:
;409:	// check for water jump
;410:	if ( pm->waterlevel != 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
EQI4 $165
line 411
;411:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $162
JUMPV
LABELV $165
line 414
;412:	}
;413:
;414:	flatforward[0] = pml.forward[0];
ADDRLP4 12
ADDRGP4 pml
INDIRF4
ASGNF4
line 415
;415:	flatforward[1] = pml.forward[1];
ADDRLP4 12+4
ADDRGP4 pml+4
INDIRF4
ASGNF4
line 416
;416:	flatforward[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 417
;417:	VectorNormalize (flatforward);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 419
;418:
;419:	VectorMA (pm->ps->origin, 30, flatforward, spot);
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
CNSTF4 1106247680
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1106247680
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 420
;420:	spot[2] += 4;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 421
;421:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRLP4 36
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 40
INDIRI4
ASGNI4
line 422
;422:	if ( !(cont & CONTENTS_SOLID) ) {
ADDRLP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $175
line 423
;423:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $162
JUMPV
LABELV $175
line 426
;424:	}
;425:
;426:	spot[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 427
;427:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 48
INDIRI4
ASGNI4
line 428
;428:	if ( cont ) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $178
line 429
;429:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $162
JUMPV
LABELV $178
line 433
;430:	}
;431:
;432:	// jump out of water
;433:	VectorScale (pml.forward, 200, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1128792064
ADDRGP4 pml
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1128792064
ADDRGP4 pml+4
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1128792064
ADDRGP4 pml+8
INDIRF4
MULF4
ASGNF4
line 434
;434:	pm->ps->velocity[2] = 350;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1135542272
ASGNF4
line 436
;435:
;436:	pm->ps->pm_flags |= PMF_TIME_WATERJUMP;
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 437
;437:	pm->ps->pm_time = 2000;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 2000
ASGNI4
line 439
;438:
;439:	return qtrue;
CNSTI4 1
RETI4
LABELV $162
endproc PM_CheckWaterJump 56 8
proc PM_WaterJumpMove 12 4
line 452
;440:}
;441:
;442://============================================================================
;443:
;444:
;445:/*
;446:===================
;447:PM_WaterJumpMove
;448:
;449:Flying out of the water
;450:===================
;451:*/
;452:static void PM_WaterJumpMove( void ) {
line 455
;453:	// waterjump has no control, but falls
;454:
;455:	PM_StepSlideMove( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 457
;456:
;457:	pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 458
;458:	if (pm->ps->velocity[2] < 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
GEF4 $184
line 460
;459:		// cancel as soon as we are falling down again
;460:		pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 461
;461:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 462
;462:	}
LABELV $184
line 463
;463:}
LABELV $182
endproc PM_WaterJumpMove 12 4
proc PM_WaterMove 76 16
line 471
;464:
;465:/*
;466:===================
;467:PM_WaterMove
;468:
;469:===================
;470:*/
;471:static void PM_WaterMove( void ) {
line 479
;472:	int		i;
;473:	vec3_t	wishvel;
;474:	float	wishspeed;
;475:	vec3_t	wishdir;
;476:	float	scale;
;477:	float	vel;
;478:
;479:	if ( PM_CheckWaterJump() ) {
ADDRLP4 40
ADDRGP4 PM_CheckWaterJump
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $187
line 480
;480:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 481
;481:		return;
ADDRGP4 $186
JUMPV
LABELV $187
line 497
;482:	}
;483:#if 0
;484:	// jump = head for surface
;485:	if ( pm->cmd.upmove >= 10 ) {
;486:		if (pm->ps->velocity[2] > -300) {
;487:			if ( pm->watertype == CONTENTS_WATER ) {
;488:				pm->ps->velocity[2] = 100;
;489:			} else if (pm->watertype == CONTENTS_SLIME) {
;490:				pm->ps->velocity[2] = 80;
;491:			} else {
;492:				pm->ps->velocity[2] = 50;
;493:			}
;494:		}
;495:	}
;496:#endif
;497:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 499
;498:
;499:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 44
INDIRF4
ASGNF4
line 503
;500:	//
;501:	// user intentions
;502:	//
;503:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $189
line 504
;504:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 505
;505:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 506
;506:		wishvel[2] = -60;		// sink towards bottom
ADDRLP4 8+8
CNSTF4 3262119936
ASGNF4
line 507
;507:	} else {
ADDRGP4 $190
JUMPV
LABELV $189
line 508
;508:		for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $193
line 509
;509:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 48
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 48
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 48
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 48
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
LABELV $194
line 508
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $193
line 511
;510:
;511:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 512
;512:	}
LABELV $190
line 514
;513:
;514:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 8
INDIRB
ASGNB 12
line 515
;515:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 48
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 517
;516:
;517:	if ( wishspeed > pm->ps->speed * pm_swimScale ) {
ADDRLP4 20
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
LEF4 $199
line 518
;518:		wishspeed = pm->ps->speed * pm_swimScale;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
ASGNF4
line 519
;519:	}
LABELV $199
line 521
;520:
;521:	PM_Accelerate (wishdir, wishspeed, pm_wateraccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 pm_wateraccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 524
;522:
;523:	// make sure we can go up slopes easily under water
;524:	if ( pml.groundPlane && DotProduct( pm->ps->velocity, pml.groundTrace.plane.normal ) < 0 ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $201
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRLP4 52
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 52
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $201
line 525
;525:		vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 56
INDIRF4
ASGNF4
line 527
;526:		// slide along the ground plane
;527:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 530
;528:			pm->ps->velocity, OVERCLIP );
;529:
;530:		VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 531
;531:		VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 532
;532:	}
LABELV $201
line 534
;533:
;534:	PM_SlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_SlideMove
CALLI4
pop
line 535
;535:}
LABELV $186
endproc PM_WaterMove 76 16
proc PM_FlyMove 52 12
line 560
;536:
;537:#ifdef MISSIONPACK
;538:/*
;539:===================
;540:PM_InvulnerabilityMove
;541:
;542:Only with the invulnerability powerup
;543:===================
;544:*/
;545:static void PM_InvulnerabilityMove( void ) {
;546:	pm->cmd.forwardmove = 0;
;547:	pm->cmd.rightmove = 0;
;548:	pm->cmd.upmove = 0;
;549:	VectorClear(pm->ps->velocity);
;550:}
;551:#endif
;552:
;553:/*
;554:===================
;555:PM_FlyMove
;556:
;557:Only with the flight powerup
;558:===================
;559:*/
;560:static void PM_FlyMove( void ) {
line 568
;561:	int		i;
;562:	vec3_t	wishvel;
;563:	float	wishspeed;
;564:	vec3_t	wishdir;
;565:	float	scale;
;566:
;567:	// normal slowdown
;568:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 570
;569:
;570:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 36
INDIRF4
ASGNF4
line 574
;571:	//
;572:	// user intentions
;573:	//
;574:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $215
line 575
;575:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 576
;576:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 577
;577:		wishvel[2] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 578
;578:	} else {
ADDRGP4 $216
JUMPV
LABELV $215
line 579
;579:		for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $219
line 580
;580:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 40
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 40
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 581
;581:		}
LABELV $220
line 579
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $219
line 583
;582:
;583:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 584
;584:	}
LABELV $216
line 586
;585:
;586:	VectorCopy (wishvel, wishdir);
ADDRLP4 20
ADDRLP4 8
INDIRB
ASGNB 12
line 587
;587:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 20
ARGP4
ADDRLP4 40
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 40
INDIRF4
ASGNF4
line 589
;588:
;589:	PM_Accelerate (wishdir, wishspeed, pm_flyaccelerate);
ADDRLP4 20
ARGP4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 pm_flyaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 591
;590:
;591:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 592
;592:}
LABELV $214
endproc PM_FlyMove 52 12
proc PM_AirMove 80 16
line 601
;593:
;594:
;595:/*
;596:===================
;597:PM_AirMove
;598:
;599:===================
;600:*/
;601:static void PM_AirMove( void ) {
line 610
;602:	int			i;
;603:	vec3_t		wishvel;
;604:	float		fmove, smove;
;605:	vec3_t		wishdir;
;606:	float		wishspeed;
;607:	float		scale;
;608:	usercmd_t	cmd;
;609:
;610:	PM_Friction();
ADDRGP4 PM_Friction
CALLV
pop
line 612
;611:
;612:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 613
;613:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 615
;614:
;615:	cmd = pm->cmd;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 616
;616:	scale = PM_CmdScale( &cmd );
ADDRLP4 44
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 68
INDIRF4
ASGNF4
line 619
;617:
;618:	// set the movementDir so clients can rotate the legs for strafing
;619:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 622
;620:
;621:	// project moves down to flat plane
;622:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 623
;623:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 624
;624:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 625
;625:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 627
;626:
;627:	for ( i = 0 ; i < 2 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $230
line 628
;628:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 72
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 72
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 72
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 629
;629:	}
LABELV $231
line 627
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $230
line 630
;630:	wishvel[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 632
;631:
;632:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 4
INDIRB
ASGNB 12
line 633
;633:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 72
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 72
INDIRF4
ASGNF4
line 634
;634:	wishspeed *= scale;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
line 637
;635:
;636:	// not on ground, so little effect on velocity
;637:	PM_Accelerate (wishdir, wishspeed, pm_airaccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 pm_airaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 642
;638:
;639:	// we may have a ground plane that is very steep, even
;640:	// though we don't have a groundentity
;641:	// slide along the steep plane
;642:	if ( pml.groundPlane ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $236
line 643
;643:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 645
;644:			pm->ps->velocity, OVERCLIP );
;645:	}
LABELV $236
line 657
;646:
;647:#if 0
;648:	//ZOID:  If we are on the grapple, try stair-stepping
;649:	//this allows a player to use the grapple to pull himself
;650:	//over a ledge
;651:	if (pm->ps->pm_flags & PMF_GRAPPLE_PULL)
;652:		PM_StepSlideMove ( qtrue );
;653:	else
;654:		PM_SlideMove ( qtrue );
;655:#endif
;656:
;657:	PM_StepSlideMove ( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 658
;658:}
LABELV $225
endproc PM_AirMove 80 16
proc PM_GrappleMove 52 4
line 666
;659:
;660:/*
;661:===================
;662:PM_GrappleMove
;663:
;664:===================
;665:*/
;666:static void PM_GrappleMove( void ) {
line 670
;667:	vec3_t vel, v;
;668:	float vlen;
;669:
;670:	VectorScale(pml.forward, -16, v);
ADDRLP4 28
CNSTF4 3246391296
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
ADDRGP4 pml
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 28
INDIRF4
ADDRGP4 pml+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+8
CNSTF4 3246391296
ADDRGP4 pml+8
INDIRF4
MULF4
ASGNF4
line 671
;671:	VectorAdd(pm->ps->grapplePoint, v, v);
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 672
;672:	VectorSubtract(v, pm->ps->origin, vel);
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+8
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 673
;673:	vlen = VectorLength(vel);
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 40
INDIRF4
ASGNF4
line 674
;674:	VectorNormalize( vel );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 676
;675:
;676:	if (vlen <= 100)
ADDRLP4 24
INDIRF4
CNSTF4 1120403456
GTF4 $254
line 677
;677:		VectorScale(vel, 10 * vlen, vel);
ADDRLP4 44
CNSTF4 1092616192
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1092616192
ADDRLP4 24
INDIRF4
MULF4
MULF4
ASGNF4
ADDRGP4 $255
JUMPV
LABELV $254
line 679
;678:	else
;679:		VectorScale(vel, 800, vel);
ADDRLP4 48
CNSTF4 1145569280
ASGNF4
ADDRLP4 0
ADDRLP4 48
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 48
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1145569280
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
LABELV $255
line 681
;680:
;681:	VectorCopy(vel, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 683
;682:
;683:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 684
;684:}
LABELV $241
endproc PM_GrappleMove 52 4
proc PM_WalkMove 128 16
line 692
;685:
;686:/*
;687:===================
;688:PM_WalkMove
;689:
;690:===================
;691:*/
;692:static void PM_WalkMove( void ) {
line 703
;693:	int			i;
;694:	vec3_t		wishvel;
;695:	float		fmove, smove;
;696:	vec3_t		wishdir;
;697:	float		wishspeed;
;698:	float		scale;
;699:	usercmd_t	cmd;
;700:	float		accelerate;
;701:	float		vel;
;702:
;703:	if ( pm->waterlevel > 2 && DotProduct( pml.forward, pml.groundTrace.plane.normal ) > 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
LEI4 $266
ADDRGP4 pml
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRGP4 pml+4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRGP4 pml+8
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
LEF4 $266
line 705
;704:		// begin swimming
;705:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 706
;706:		return;
ADDRGP4 $265
JUMPV
LABELV $266
line 710
;707:	}
;708:
;709:
;710:	if ( PM_CheckJump () ) {
ADDRLP4 76
ADDRGP4 PM_CheckJump
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $278
line 712
;711:		// jumped away
;712:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LEI4 $280
line 713
;713:			PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 714
;714:		} else {
ADDRGP4 $265
JUMPV
LABELV $280
line 715
;715:			PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 716
;716:		}
line 717
;717:		return;
ADDRGP4 $265
JUMPV
LABELV $278
line 720
;718:	}
;719:
;720:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 722
;721:
;722:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 723
;723:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 725
;724:
;725:	cmd = pm->cmd;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 726
;726:	scale = PM_CmdScale( &cmd );
ADDRLP4 48
ARGP4
ADDRLP4 80
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 80
INDIRF4
ASGNF4
line 729
;727:
;728:	// set the movementDir so clients can rotate the legs for strafing
;729:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 732
;730:
;731:	// project moves down to flat plane
;732:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 733
;733:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 736
;734:
;735:	// project the forward and right directions onto the ground plane
;736:	PM_ClipVelocity (pml.forward, pml.groundTrace.plane.normal, pml.forward, OVERCLIP );
ADDRLP4 84
ADDRGP4 pml
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 737
;737:	PM_ClipVelocity (pml.right, pml.groundTrace.plane.normal, pml.right, OVERCLIP );
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRGP4 pml+12
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 739
;738:	//
;739:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 740
;740:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 742
;741:
;742:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $292
line 743
;743:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 88
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 88
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 88
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 744
;744:	}
LABELV $293
line 742
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $292
line 748
;745:	// when going up or down slopes the wish velocity should Not be zero
;746://	wishvel[2] = 0;
;747:
;748:	VectorCopy (wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 749
;749:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 88
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 88
INDIRF4
ASGNF4
line 750
;750:	wishspeed *= scale;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
line 753
;751:
;752:	// clamp the speed lower if ducking
;753:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $297
line 754
;754:		if ( wishspeed > pm->ps->speed * pm_duckScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
LEF4 $299
line 755
;755:			wishspeed = pm->ps->speed * pm_duckScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
ASGNF4
line 756
;756:		}
LABELV $299
line 757
;757:	}
LABELV $297
line 760
;758:
;759:	// clamp the speed lower if wading or walking on the bottom
;760:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
EQI4 $301
line 763
;761:		float	waterScale;
;762:
;763:		waterScale = pm->waterlevel / 3.0;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1077936128
DIVF4
ASGNF4
line 764
;764:		waterScale = 1.0 - ( 1.0 - pm_swimScale ) * waterScale;
ADDRLP4 96
CNSTF4 1065353216
ASGNF4
ADDRLP4 92
ADDRLP4 96
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 pm_swimScale
INDIRF4
SUBF4
ADDRLP4 92
INDIRF4
MULF4
SUBF4
ASGNF4
line 765
;765:		if ( wishspeed > pm->ps->speed * waterScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
LEF4 $303
line 766
;766:			wishspeed = pm->ps->speed * waterScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
line 767
;767:		}
LABELV $303
line 768
;768:	}
LABELV $301
line 772
;769:
;770:	// when a player gets hit, they temporarily lose
;771:	// full control, which allows them to be moved a bit
;772:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 92
INDIRI4
NEI4 $309
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 92
INDIRI4
EQI4 $305
LABELV $309
line 773
;773:		accelerate = pm_airaccelerate;
ADDRLP4 72
ADDRGP4 pm_airaccelerate
INDIRF4
ASGNF4
line 774
;774:	} else {
ADDRGP4 $306
JUMPV
LABELV $305
line 775
;775:		accelerate = pm_accelerate;
ADDRLP4 72
ADDRGP4 pm_accelerate
INDIRF4
ASGNF4
line 776
;776:	}
LABELV $306
line 778
;777:
;778:	PM_Accelerate (wishdir, wishspeed, accelerate);
ADDRLP4 32
ARGP4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 783
;779:
;780:	//Com_Printf("velocity = %1.1f %1.1f %1.1f\n", pm->ps->velocity[0], pm->ps->velocity[1], pm->ps->velocity[2]);
;781:	//Com_Printf("velocity1 = %1.1f\n", VectorLength(pm->ps->velocity));
;782:
;783:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 96
INDIRI4
NEI4 $314
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 96
INDIRI4
EQI4 $310
LABELV $314
line 784
;784:		pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 100
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 104
ADDRLP4 100
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 785
;785:	} else {
LABELV $310
line 788
;786:		// don't reset the z velocity for slopes
;787://		pm->ps->velocity[2] = 0;
;788:	}
LABELV $311
line 790
;789:
;790:	vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 100
INDIRF4
ASGNF4
line 793
;791:
;792:	// slide along the ground plane
;793:	PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 104
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 797
;794:		pm->ps->velocity, OVERCLIP );
;795:
;796:	// don't decrease velocity when going up or down a slope
;797:	VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 798
;798:	VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 108
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 112
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 116
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 801
;799:
;800:	// don't do anything if standing still
;801:	if (!pm->ps->velocity[0] && !pm->ps->velocity[1]) {
ADDRLP4 120
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 124
CNSTF4 0
ASGNF4
ADDRLP4 120
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 124
INDIRF4
NEF4 $318
ADDRLP4 120
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 124
INDIRF4
NEF4 $318
line 802
;802:		return;
ADDRGP4 $265
JUMPV
LABELV $318
line 805
;803:	}
;804:
;805:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 809
;806:
;807:	//Com_Printf("velocity2 = %1.1f\n", VectorLength(pm->ps->velocity));
;808:
;809:}
LABELV $265
endproc PM_WalkMove 128 16
proc PM_DeadMove 20 4
line 817
;810:
;811:
;812:/*
;813:==============
;814:PM_DeadMove
;815:==============
;816:*/
;817:static void PM_DeadMove( void ) {
line 820
;818:	float	forward;
;819:
;820:	if ( !pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
NEI4 $321
line 821
;821:		return;
ADDRGP4 $320
JUMPV
LABELV $321
line 826
;822:	}
;823:
;824:	// extra friction
;825:
;826:	forward = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 827
;827:	forward -= 20;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 828
;828:	if ( forward <= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $324
line 829
;829:		VectorClear (pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 830
;830:	} else {
ADDRGP4 $325
JUMPV
LABELV $324
line 831
;831:		VectorNormalize (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 832
;832:		VectorScale (pm->ps->velocity, forward, pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 833
;833:	}
LABELV $325
line 834
;834:}
LABELV $320
endproc PM_DeadMove 20 4
proc PM_NoclipMove 104 12
line 842
;835:
;836:
;837:/*
;838:===============
;839:PM_NoclipMove
;840:===============
;841:*/
;842:static void PM_NoclipMove( void ) {
line 851
;843:	float	speed, drop, friction, control, newspeed;
;844:	int			i;
;845:	vec3_t		wishvel;
;846:	float		fmove, smove;
;847:	vec3_t		wishdir;
;848:	float		wishspeed;
;849:	float		scale;
;850:
;851:	pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 855
;852:
;853:	// friction
;854:
;855:	speed = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 64
INDIRF4
ASGNF4
line 856
;856:	if (speed < 1)
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
GEF4 $327
line 857
;857:	{
line 858
;858:		VectorCopy (vec3_origin, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 859
;859:	}
ADDRGP4 $328
JUMPV
LABELV $327
line 861
;860:	else
;861:	{
line 862
;862:		drop = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 864
;863:
;864:		friction = pm_friction*1.5;	// extra friction
ADDRLP4 56
CNSTF4 1069547520
ADDRGP4 pm_friction
INDIRF4
MULF4
ASGNF4
line 865
;865:		control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 24
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $330
ADDRLP4 68
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $331
JUMPV
LABELV $330
ADDRLP4 68
ADDRLP4 24
INDIRF4
ASGNF4
LABELV $331
ADDRLP4 60
ADDRLP4 68
INDIRF4
ASGNF4
line 866
;866:		drop += control*friction*pml.frametime;
ADDRLP4 52
ADDRLP4 52
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 869
;867:
;868:		// scale the velocity
;869:		newspeed = speed - drop;
ADDRLP4 28
ADDRLP4 24
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
line 870
;870:		if (newspeed < 0)
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $333
line 871
;871:			newspeed = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
LABELV $333
line 872
;872:		newspeed /= speed;
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
DIVF4
ASGNF4
line 874
;873:
;874:		VectorScale (pm->ps->velocity, newspeed, pm->ps->velocity);
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 875
;875:	}
LABELV $328
line 878
;876:
;877:	// accelerate
;878:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 68
INDIRF4
ASGNF4
line 880
;879:
;880:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 881
;881:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 883
;882:	
;883:	for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $335
line 884
;884:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 72
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 72
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 72
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $336
line 883
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $335
line 885
;885:	wishvel[2] += pm->cmd.upmove;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ADDF4
ASGNF4
line 887
;886:
;887:	VectorCopy (wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 888
;888:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 76
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 76
INDIRF4
ASGNF4
line 889
;889:	wishspeed *= scale;
ADDRLP4 44
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 891
;890:
;891:	PM_Accelerate( wishdir, wishspeed, pm_accelerate );
ADDRLP4 32
ARGP4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 pm_accelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 894
;892:
;893:	// move
;894:	VectorMA (pm->ps->origin, pml.frametime, pm->ps->velocity, pm->ps->origin);
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 88
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 100
ADDRLP4 96
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 895
;895:}
LABELV $326
endproc PM_NoclipMove 104 12
proc PM_FootstepForSurface 0 0
line 906
;896:
;897://============================================================================
;898:
;899:/*
;900:================
;901:PM_FootstepForSurface
;902:
;903:Returns an event number apropriate for the groundsurface
;904:================
;905:*/
;906:static int PM_FootstepForSurface( void ) {
line 907
;907:	if ( pml.groundTrace.surfaceFlags & SURF_NOSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $345
line 908
;908:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $344
JUMPV
LABELV $345
line 910
;909:	}
;910:	if ( pml.groundTrace.surfaceFlags & SURF_METALSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $349
line 911
;911:		return EV_FOOTSTEP_METAL;
CNSTI4 2
RETI4
ADDRGP4 $344
JUMPV
LABELV $349
line 913
;912:	}
;913:	return EV_FOOTSTEP;
CNSTI4 1
RETI4
LABELV $344
endproc PM_FootstepForSurface 0 0
proc PM_CrashLand 180 8
line 924
;914:}
;915:
;916:
;917:/*
;918:=================
;919:PM_CrashLand
;920:
;921:Check for hard landings that generate sound events
;922:=================
;923:*/
;924:static void PM_CrashLand( void ) {
line 936
;925:	float		delta;
;926:	float		dist;
;927:	float		vel, acc;
;928:	float		t;
;929:	float		a, b, c, den;
;930:	float		dot;
;931:	vec3_t		playervel, pvnorm;
;932:	vec3_t		angles, forward, right, up;
;933:	float		differential;
;934:
;935:	// decide which landing animation to use
;936:	if ( pm->ps->pm_flags & PMF_BACKWARDS_JUMP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $354
line 937
;937:		PM_ForceLegsAnim( LEGS_LANDB );
CNSTI4 21
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 938
;938:	} else {
ADDRGP4 $355
JUMPV
LABELV $354
line 939
;939:		PM_ForceLegsAnim( LEGS_LAND );
CNSTI4 19
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 940
;940:	}
LABELV $355
line 942
;941:
;942:	pm->ps->legsTimer = TIMER_LAND;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 130
ASGNI4
line 945
;943:
;944:	// calculate the exact velocity on landing
;945:	dist = pm->ps->origin[2] - pml.previous_origin[2];
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 pml+112+8
INDIRF4
SUBF4
ASGNF4
line 946
;946:	vel = pml.previous_velocity[2];
ADDRLP4 20
ADDRGP4 pml+124+8
INDIRF4
ASGNF4
line 947
;947:	acc = -pm->ps->gravity;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 949
;948:
;949:	a = acc / 2;
ADDRLP4 28
ADDRLP4 24
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 950
;950:	b = vel;
ADDRLP4 16
ADDRLP4 20
INDIRF4
ASGNF4
line 951
;951:	c = -dist;
ADDRLP4 56
ADDRLP4 48
INDIRF4
NEGF4
ASGNF4
line 953
;952:
;953:	den =  b * b - 4 * a * c;
ADDRLP4 32
ADDRLP4 16
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
CNSTF4 1082130432
ADDRLP4 28
INDIRF4
MULF4
ADDRLP4 56
INDIRF4
MULF4
SUBF4
ASGNF4
line 954
;954:	if ( den < 0 ) {
ADDRLP4 32
INDIRF4
CNSTF4 0
GEF4 $360
line 955
;955:		return;
ADDRGP4 $353
JUMPV
LABELV $360
line 957
;956:	}
;957:	t = (-b - sqrt( den ) ) / ( 2 * a );
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 120
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 16
INDIRF4
NEGF4
ADDRLP4 120
INDIRF4
SUBF4
CNSTF4 1073741824
ADDRLP4 28
INDIRF4
MULF4
DIVF4
ASGNF4
line 959
;958:
;959:	delta = vel + t * acc;
ADDRLP4 0
ADDRLP4 20
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
line 960
;960:	delta = delta*delta * 0.0001;
ADDRLP4 0
CNSTF4 953267991
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
MULF4
ASGNF4
line 963
;961:
;962:	// ducking while falling doubles damage
;963:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $362
line 964
;964:		delta *= 2;
ADDRLP4 0
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 965
;965:	}
LABELV $362
line 968
;966:
;967:	// never take falling damage if completely underwater
;968:	if ( pm->waterlevel == 3 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 3
NEI4 $364
line 969
;969:		return;
ADDRGP4 $353
JUMPV
LABELV $364
line 973
;970:	}
;971:
;972:	// reduce falling damage if there is standing water
;973:	if ( pm->waterlevel == 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
NEI4 $366
line 974
;974:		delta *= 0.25;
ADDRLP4 0
CNSTF4 1048576000
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 975
;975:	}
LABELV $366
line 976
;976:	if ( pm->waterlevel == 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
NEI4 $368
line 977
;977:		delta *= 0.5;
ADDRLP4 0
CNSTF4 1056964608
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 978
;978:	}
LABELV $368
line 980
;979:
;980:	if ( delta < 1 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $370
line 981
;981:		return;
ADDRGP4 $353
JUMPV
LABELV $370
line 990
;982:	}
;983:
;984:	// create a local entity event to play the sound
;985:
;986:	// MY CODE: Trampolines
;987:	// They reflect 80% of the player's velocity, while also adding 70% of the forward and lateral velocities to the vertical velocity
;988:	// This means a player gets a bigger upwards boost if they approach a trampoline while having accumulated some speed, regardless of direction
;989:	// A player can duck to avoid receiving a boost if desired
;990:	if (pml.groundTrace.surfaceFlags & SURF_LADDER && !(pm->ps->pm_flags & PMF_DUCKED) ) {
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 128
INDIRI4
EQI4 $372
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 128
INDIRI4
NEI4 $372
line 991
;991:		delta = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 992
;992:		PM_AddEvent(EV_BOUNCE);
CNSTI4 13
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 993
;993:		VectorCopy(pml.previous_velocity, pvnorm);
ADDRLP4 36
ADDRGP4 pml+124
INDIRB
ASGNB 12
line 994
;994:		VectorNormalize(pvnorm);
ADDRLP4 36
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 995
;995:		dot = DotProduct(pml.groundTrace.plane.normal, pvnorm);
ADDRLP4 60
ADDRGP4 pml+52+24
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDRGP4 pml+52+24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
MULF4
ADDF4
ADDRGP4 pml+52+24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 997
;996:		// VectorScale(pm->ps->velocity, VectorLength(pml.previous_velocity), pm->ps->velocity);
;997:		pm->ps->velocity[2] = abs(pm->ps->velocity[0] * 0.7) + abs(pm->ps->velocity[1] * 0.7) + abs(pm->ps->velocity[2]);
ADDRLP4 132
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
CNSTF4 1060320051
ADDRLP4 132
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
CVFI4 4
ARGI4
ADDRLP4 136
ADDRGP4 abs
CALLI4
ASGNI4
CNSTF4 1060320051
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
MULF4
CVFI4 4
ARGI4
ADDRLP4 140
ADDRGP4 abs
CALLI4
ASGNI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 144
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 132
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 136
INDIRI4
ADDRLP4 140
INDIRI4
ADDI4
ADDRLP4 144
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 1000
;998:		// pm->ps->velocity[0] *= 1.5;
;999:		// pm->ps->velocity[1] *= 1.5;
;1000:		VectorCopy(pm->ps->velocity, playervel);
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 1001
;1001:		VectorMA(playervel, -2 * dot * VectorLength(pml.previous_velocity), pml.groundTrace.plane.normal, playervel);
ADDRGP4 pml+124
ARGP4
ADDRLP4 148
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
CNSTF4 3221225472
ADDRLP4 60
INDIRF4
MULF4
ADDRLP4 148
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRGP4 pml+124
ARGP4
ADDRLP4 152
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
CNSTF4 3221225472
ADDRLP4 60
INDIRF4
MULF4
ADDRLP4 152
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRGP4 pml+124
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
CNSTF4 3221225472
ADDRLP4 60
INDIRF4
MULF4
ADDRLP4 156
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1002
;1002:		VectorScale(playervel, 0.4, playervel);
ADDRLP4 160
CNSTF4 1053609165
ASGNF4
ADDRLP4 4
ADDRLP4 160
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 160
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+8
CNSTF4 1053609165
ADDRLP4 4+8
INDIRF4
MULF4
ASGNF4
line 1003
;1003:		differential = abs(VectorLength(playervel)) - abs(VectorLength(pml.previous_velocity));
ADDRLP4 4
ARGP4
ADDRLP4 164
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 164
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 168
ADDRGP4 abs
CALLI4
ASGNI4
ADDRGP4 pml+124
ARGP4
ADDRLP4 172
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 172
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 176
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 64
ADDRLP4 168
INDIRI4
ADDRLP4 176
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 1006
;1004:		/* Com_Printf("New Velocity: %f \n", VectorLength(pm->ps->velocity));
;1005:		Com_Printf("Old Velocity: %f \n", VectorLength(pml.previous_velocity)); */
;1006:		Com_Printf("Difference: %f \n", differential);
ADDRGP4 $407
ARGP4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 Com_Printf
CALLV
pop
line 1010
;1007:		/* VectorNormalize2(playervel, pvnorm);
;1008:		VectorScale(pvnorm, 50, pvnorm);
;1009:		VectorAdd(pvnorm, playervel, playervel); */
;1010:		VectorCopy(playervel, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 1011
;1011:	}
LABELV $372
line 1013
;1012:
;1013:	if (pml.groundTrace.surfaceFlags & SURF_LADDER && (pm->ps->pm_flags & PMF_DUCKED)) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 132
INDIRI4
EQI4 $408
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 132
INDIRI4
EQI4 $408
line 1014
;1014:		delta = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1015
;1015:	}
LABELV $408
line 1019
;1016:
;1017:	// SURF_NODAMAGE is used for bounce pads where you don't ever
;1018:	// want to take damage or play a crunch sound
;1019:	if ( !(pml.groundTrace.surfaceFlags & SURF_NODAMAGE) )  {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $412
line 1020
;1020:		if ( delta > 60 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1114636288
LEF4 $416
line 1021
;1021:			PM_AddEvent( EV_FALL_FAR );
CNSTI4 12
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1022
;1022:		} else if ( delta > 40 ) {
ADDRGP4 $417
JUMPV
LABELV $416
ADDRLP4 0
INDIRF4
CNSTF4 1109393408
LEF4 $418
line 1024
;1023:			// this is a pain grunt, so don't play it if dead
;1024:			if ( pm->ps->stats[STAT_HEALTH] > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $419
line 1025
;1025:				PM_AddEvent( EV_FALL_MEDIUM );
CNSTI4 11
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1026
;1026:			}
line 1027
;1027:		} else if ( delta > 7 ) {
ADDRGP4 $419
JUMPV
LABELV $418
ADDRLP4 0
INDIRF4
CNSTF4 1088421888
LEF4 $422
line 1028
;1028:			PM_AddEvent( EV_FALL_SHORT );
CNSTI4 10
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1029
;1029:		} else {
ADDRGP4 $423
JUMPV
LABELV $422
line 1030
;1030:			PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 136
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1031
;1031:		}
LABELV $423
LABELV $419
LABELV $417
line 1032
;1032:	}
LABELV $412
line 1035
;1033:
;1034:	// start footstep cycle over
;1035:	pm->ps->bobCycle = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1036
;1036:}
LABELV $353
endproc PM_CrashLand 180 8
proc PM_CorrectAllSolid 36 28
line 1059
;1037:
;1038:/*
;1039:=============
;1040:PM_CheckStuck
;1041:=============
;1042:*/
;1043:/*
;1044:void PM_CheckStuck(void) {
;1045:	trace_t trace;
;1046:
;1047:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask);
;1048:	if (trace.allsolid) {
;1049:		//int shit = qtrue;
;1050:	}
;1051:}
;1052:*/
;1053:
;1054:/*
;1055:=============
;1056:PM_CorrectAllSolid
;1057:=============
;1058:*/
;1059:static int PM_CorrectAllSolid( trace_t *trace ) {
line 1063
;1060:	int			i, j, k;
;1061:	vec3_t		point;
;1062:
;1063:	if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $425
line 1064
;1064:		Com_Printf("%i:allsolid\n", c_pmove);
ADDRGP4 $427
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1065
;1065:	}
LABELV $425
line 1068
;1066:
;1067:	// jitter around
;1068:	for (i = -1; i <= 1; i++) {
ADDRLP4 20
CNSTI4 -1
ASGNI4
LABELV $428
line 1069
;1069:		for (j = -1; j <= 1; j++) {
ADDRLP4 16
CNSTI4 -1
ASGNI4
LABELV $432
line 1070
;1070:			for (k = -1; k <= 1; k++) {
ADDRLP4 12
CNSTI4 -1
ASGNI4
LABELV $436
line 1071
;1071:				VectorCopy(pm->ps->origin, point);
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1072
;1072:				point[0] += (float) i;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1073
;1073:				point[1] += (float) j;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1074
;1074:				point[2] += (float) k;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1075
;1075:				pm->trace (trace, point, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CALLV
pop
line 1076
;1076:				if ( !trace->allsolid ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $442
line 1077
;1077:					point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1078
;1078:					point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1079
;1079:					point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1081
;1080:
;1081:					pm->trace (trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CALLV
pop
line 1082
;1082:					pml.groundTrace = *trace;
ADDRGP4 pml+52
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 56
line 1083
;1083:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $424
JUMPV
LABELV $442
line 1085
;1084:				}
;1085:			}
LABELV $437
line 1070
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
LEI4 $436
line 1086
;1086:		}
LABELV $433
line 1069
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LEI4 $432
line 1087
;1087:	}
LABELV $429
line 1068
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
LEI4 $428
line 1089
;1088:
;1089:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1090
;1090:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1091
;1091:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1093
;1092:
;1093:	return qfalse;
CNSTI4 0
RETI4
LABELV $424
endproc PM_CorrectAllSolid 36 28
proc PM_GroundTraceMissed 80 28
line 1104
;1094:}
;1095:
;1096:
;1097:/*
;1098:=============
;1099:PM_GroundTraceMissed
;1100:
;1101:The ground trace didn't hit a surface, so we are in freefall
;1102:=============
;1103:*/
;1104:static void PM_GroundTraceMissed( void ) {
line 1108
;1105:	trace_t		trace;
;1106:	vec3_t		point;
;1107:
;1108:	if ( pm->ps->groundEntityNum != ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $450
line 1110
;1109:		// we just transitioned into freefall
;1110:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $452
line 1111
;1111:			Com_Printf("%i:lift\n", c_pmove);
ADDRGP4 $454
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1112
;1112:		}
LABELV $452
line 1116
;1113:
;1114:		// if they aren't in a jumping animation and the ground is a ways away, force into it
;1115:		// if we didn't do the trace, the player would be backflipping down staircases
;1116:		VectorCopy( pm->ps->origin, point );
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1117
;1117:		point[2] -= 64;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 1119
;1118:
;1119:		pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 12
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CALLV
pop
line 1120
;1120:		if ( trace.fraction == 1.0 ) {
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $456
line 1121
;1121:			if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $459
line 1122
;1122:				PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1123
;1123:				pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1124
;1124:			} else {
ADDRGP4 $460
JUMPV
LABELV $459
line 1125
;1125:				PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1126
;1126:				pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1127
;1127:			}
LABELV $460
line 1128
;1128:		}
LABELV $456
line 1129
;1129:	}
LABELV $450
line 1131
;1130:
;1131:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1132
;1132:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1133
;1133:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1134
;1134:}
LABELV $449
endproc PM_GroundTraceMissed 80 28
proc PM_GroundTrace 88 28
line 1142
;1135:
;1136:
;1137:/*
;1138:=============
;1139:PM_GroundTrace
;1140:=============
;1141:*/
;1142:static void PM_GroundTrace( void ) {
line 1146
;1143:	vec3_t		point;
;1144:	trace_t		trace;
;1145:
;1146:	point[0] = pm->ps->origin[0];
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1147
;1147:	point[1] = pm->ps->origin[1];
ADDRLP4 56+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1148
;1148:	point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 56+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1150
;1149:
;1150:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CALLV
pop
line 1151
;1151:	pml.groundTrace = trace;
ADDRGP4 pml+52
ADDRLP4 0
INDIRB
ASGNB 56
line 1154
;1152:
;1153:	// do something corrective if the trace starts in a solid...
;1154:	if ( trace.allsolid ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $467
line 1155
;1155:		if ( !PM_CorrectAllSolid(&trace) )
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 PM_CorrectAllSolid
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $469
line 1156
;1156:			return;
ADDRGP4 $463
JUMPV
LABELV $469
line 1157
;1157:	}
LABELV $467
line 1160
;1158:
;1159:	// if the trace didn't hit anything, we are in free fall
;1160:	if ( trace.fraction == 1.0 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $471
line 1161
;1161:		PM_GroundTraceMissed();
ADDRGP4 PM_GroundTraceMissed
CALLV
pop
line 1162
;1162:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1163
;1163:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1164
;1164:		return;
ADDRGP4 $463
JUMPV
LABELV $471
line 1168
;1165:	}
;1166:
;1167:	// check if getting thrown off the ground
;1168:	if ( pm->ps->velocity[2] > 0 && DotProduct( pm->ps->velocity, trace.plane.normal ) > 10 ) {
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 76
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ASGNF4
ADDRLP4 80
INDIRF4
CNSTF4 0
LEF4 $476
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
MULF4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 80
INDIRF4
ADDRLP4 0+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
LEF4 $476
line 1169
;1169:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $483
line 1170
;1170:			Com_Printf("%i:kickoff\n", c_pmove);
ADDRGP4 $485
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1171
;1171:		}
LABELV $483
line 1173
;1172:		// go into jump animation
;1173:		if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $486
line 1174
;1174:			PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1175
;1175:			pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1176
;1176:		} else {
ADDRGP4 $487
JUMPV
LABELV $486
line 1177
;1177:			PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1178
;1178:			pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1179
;1179:		}
LABELV $487
line 1181
;1180:
;1181:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1182
;1182:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1183
;1183:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1184
;1184:		return;
ADDRGP4 $463
JUMPV
LABELV $476
line 1188
;1185:	}
;1186:	
;1187:	// slopes that are too steep will not be considered onground
;1188:	if ( trace.plane.normal[2] < MIN_WALK_NORMAL ) {
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1060320051
GEF4 $490
line 1189
;1189:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $494
line 1190
;1190:			Com_Printf("%i:steep\n", c_pmove);
ADDRGP4 $496
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1191
;1191:		}
LABELV $494
line 1194
;1192:		// FIXME: if they can't slide down the slope, let them
;1193:		// walk (sharp crevices)
;1194:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1195
;1195:		pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1196
;1196:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1197
;1197:		return;
ADDRGP4 $463
JUMPV
LABELV $490
line 1200
;1198:	}
;1199:
;1200:	pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1201
;1201:	pml.walking = qtrue;
ADDRGP4 pml+44
CNSTI4 1
ASGNI4
line 1204
;1202:
;1203:	// hitting solid ground will end a waterjump
;1204:	if (pm->ps->pm_flags & PMF_TIME_WATERJUMP)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $501
line 1205
;1205:	{
line 1206
;1206:		pm->ps->pm_flags &= ~(PMF_TIME_WATERJUMP | PMF_TIME_LAND);
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 -289
BANDI4
ASGNI4
line 1207
;1207:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1208
;1208:	}
LABELV $501
line 1210
;1209:
;1210:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $503
line 1212
;1211:		// just hit the ground
;1212:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $505
line 1213
;1213:			Com_Printf("%i:Land\n", c_pmove);
ADDRGP4 $507
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1214
;1214:		}
LABELV $505
line 1216
;1215:		
;1216:		PM_CrashLand();
ADDRGP4 PM_CrashLand
CALLV
pop
line 1219
;1217:
;1218:		// don't do landing time if we were just going down a slope
;1219:		if ( pml.previous_velocity[2] < -200 ) {
ADDRGP4 pml+124+8
INDIRF4
CNSTF4 3276275712
GEF4 $508
line 1221
;1220:			// don't allow another jump for a little while
;1221:			pm->ps->pm_flags |= PMF_TIME_LAND;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1222
;1222:			pm->ps->pm_time = 250;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 250
ASGNI4
line 1223
;1223:		}
LABELV $508
line 1224
;1224:	}
LABELV $503
line 1233
;1225:
;1226:
;1227:	/* if (trace.surfaceFlags & SURF_LADDER)
;1228:		Com_Printf("JUMP");
;1229:
;1230:	if (pml.groundTrace.surfaceFlags & SURF_LADDER)
;1231:		Com_Printf("BOUNCE"); */
;1232:
;1233:	pm->ps->groundEntityNum = trace.entityNum;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 1238
;1234:
;1235:	// don't reset the z velocity for slopes
;1236://	pm->ps->velocity[2] = 0;
;1237:
;1238:	PM_AddTouchEnt( trace.entityNum );
ADDRLP4 0+52
INDIRI4
ARGI4
ADDRGP4 PM_AddTouchEnt
CALLV
pop
line 1239
;1239:}
LABELV $463
endproc PM_GroundTrace 88 28
proc PM_SetWaterLevel 48 8
line 1247
;1240:
;1241:
;1242:/*
;1243:=============
;1244:PM_SetWaterLevel	FIXME: avoid this twice?  certainly if not moving
;1245:=============
;1246:*/
;1247:static void PM_SetWaterLevel( void ) {
line 1256
;1248:	vec3_t		point;
;1249:	int			cont;
;1250:	int			sample1;
;1251:	int			sample2;
;1252:
;1253:	//
;1254:	// get waterlevel, accounting for ducking
;1255:	//
;1256:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 0
ASGNI4
line 1257
;1257:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 1259
;1258:
;1259:	point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1260
;1260:	point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1261
;1261:	point[2] = pm->ps->origin[2] + MINS_Z + 1;	
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1262
;1262:	cont = pm->pointcontents( point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 1264
;1263:
;1264:	if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $517
line 1265
;1265:		sample2 = pm->ps->viewheight - MINS_Z;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 -24
SUBI4
ASGNI4
line 1266
;1266:		sample1 = sample2 / 2;
ADDRLP4 20
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1268
;1267:
;1268:		pm->watertype = cont;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1269
;1269:		pm->waterlevel = 1;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 1
ASGNI4
line 1270
;1270:		point[2] = pm->ps->origin[2] + MINS_Z + sample1;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1271
;1271:		cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 1272
;1272:		if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $520
line 1273
;1273:			pm->waterlevel = 2;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 2
ASGNI4
line 1274
;1274:			point[2] = pm->ps->origin[2] + MINS_Z + sample2;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1275
;1275:			cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 1276
;1276:			if ( cont & MASK_WATER ){
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $523
line 1277
;1277:				pm->waterlevel = 3;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 3
ASGNI4
line 1278
;1278:			}
LABELV $523
line 1279
;1279:		}
LABELV $520
line 1280
;1280:	}
LABELV $517
line 1282
;1281:
;1282:}
LABELV $514
endproc PM_SetWaterLevel 48 8
proc PM_SetReverse 36 8
line 1289
;1283:
;1284:/*
;1285:=============
;1286:PM_SetReverse
;1287:=============
;1288:*/
;1289:static void PM_SetReverse(void) {
line 1295
;1290:	vec3_t		point;
;1291:	int			cont;
;1292:	int			sample1;
;1293:	int			sample2;
;1294:
;1295:	point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1296
;1296:	point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1297
;1297:	point[2] = pm->ps->origin[2] + MINS_Z + 1;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1298
;1298:	cont = pm->pointcontents(point, pm->ps->clientNum);
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 1300
;1299:
;1300:	if (cont & CONTENTS_MONSTERCLIP) {
ADDRLP4 12
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $528
line 1301
;1301:		pm->ps->eFlags |= EF_UPSIDEDOWN;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 4194304
BORI4
ASGNI4
line 1302
;1302:	}
LABELV $528
line 1304
;1303:
;1304:}
LABELV $525
endproc PM_SetReverse 36 8
proc PM_CheckDuck 76 28
line 1314
;1305:
;1306:/*
;1307:==============
;1308:PM_CheckDuck
;1309:
;1310:Sets mins, maxs, and pm->ps->viewheight
;1311:==============
;1312:*/
;1313:static void PM_CheckDuck (void)
;1314:{
line 1317
;1315:	trace_t	trace;
;1316:
;1317:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
CNSTI4 0
EQI4 $531
line 1318
;1318:		if ( pm->ps->pm_flags & PMF_INVULEXPAND ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $533
line 1320
;1319:			// invulnerability sphere has a 42 units radius
;1320:			VectorSet( pm->mins, -42, -42, -42 );
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3257401344
ASGNF4
line 1321
;1321:			VectorSet( pm->maxs, 42, 42, 42 );
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1109917696
ASGNF4
line 1322
;1322:		}
ADDRGP4 $534
JUMPV
LABELV $533
line 1323
;1323:		else {
line 1324
;1324:			VectorSet( pm->mins, -15, -15, MINS_Z );
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3250585600
ASGNF4
line 1325
;1325:			VectorSet( pm->maxs, 15, 15, 16 );
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1098907648
ASGNF4
line 1326
;1326:		}
LABELV $534
line 1327
;1327:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1328
;1328:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1329
;1329:		return;
ADDRGP4 $530
JUMPV
LABELV $531
line 1331
;1330:	}
;1331:	pm->ps->pm_flags &= ~PMF_INVULEXPAND;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1333
;1332:
;1333:	pm->mins[0] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3245342720
ASGNF4
line 1334
;1334:	pm->mins[1] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3245342720
ASGNF4
line 1336
;1335:
;1336:	pm->maxs[0] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1097859072
ASGNF4
line 1337
;1337:	pm->maxs[1] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1097859072
ASGNF4
line 1339
;1338:
;1339:	pm->mins[2] = MINS_Z;
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3250585600
ASGNF4
line 1341
;1340:
;1341:	if (pm->ps->pm_type == PM_DEAD)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $535
line 1342
;1342:	{
line 1343
;1343:		pm->maxs[2] = -8;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 3238002688
ASGNF4
line 1344
;1344:		pm->ps->viewheight = DEAD_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 -16
ASGNI4
line 1345
;1345:		return;
ADDRGP4 $530
JUMPV
LABELV $535
line 1348
;1346:	}
;1347:
;1348:	if (pm->cmd.upmove < 0)
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $537
line 1349
;1349:	{	// duck
line 1350
;1350:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1351
;1351:	}
ADDRGP4 $538
JUMPV
LABELV $537
line 1353
;1352:	else
;1353:	{	// stand up if possible
line 1354
;1354:		if (pm->ps->pm_flags & PMF_DUCKED)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $539
line 1355
;1355:		{
line 1357
;1356:			// try to stand up
;1357:			pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1107296256
ASGNF4
line 1358
;1358:			pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask );
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CALLV
pop
line 1359
;1359:			if (!trace.allsolid)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $541
line 1360
;1360:				pm->ps->pm_flags &= ~PMF_DUCKED;
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
LABELV $541
line 1361
;1361:		}
LABELV $539
line 1362
;1362:	}
LABELV $538
line 1364
;1363:
;1364:	if (pm->ps->pm_flags & PMF_DUCKED)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $543
line 1365
;1365:	{
line 1366
;1366:		pm->maxs[2] = 16;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1098907648
ASGNF4
line 1367
;1367:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1368
;1368:		if (pm->ps->velocity[2] >= 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
LTF4 $544
line 1369
;1369:			pm->ps->velocity[2] *= 0.95;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTF4 1064514355
ADDRLP4 60
INDIRP4
INDIRF4
MULF4
ASGNF4
line 1370
;1370:		}
line 1371
;1371:	}
ADDRGP4 $544
JUMPV
LABELV $543
line 1373
;1372:	else
;1373:	{
line 1374
;1374:		pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1107296256
ASGNF4
line 1375
;1375:		pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 1376
;1376:	}
LABELV $544
line 1377
;1377:}
LABELV $530
endproc PM_CheckDuck 76 28
proc PM_Footsteps 52 4
line 1389
;1378:
;1379:
;1380:
;1381://===================================================================
;1382:
;1383:
;1384:/*
;1385:===============
;1386:PM_Footsteps
;1387:===============
;1388:*/
;1389:static void PM_Footsteps( void ) {
line 1398
;1390:	float		bobmove;
;1391:	int			old;
;1392:	qboolean	footstep;
;1393:
;1394:	//
;1395:	// calculate speed and cycle to be used for
;1396:	// all cyclic walking effects
;1397:	//
;1398:	pm->xyspeed = sqrt( pm->ps->velocity[0] * pm->ps->velocity[0]
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 24
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 28
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 212
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
line 1401
;1399:		+  pm->ps->velocity[1] * pm->ps->velocity[1] );
;1400:
;1401:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $548
line 1403
;1402:
;1403:		if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
CNSTI4 0
EQI4 $550
line 1404
;1404:			PM_ContinueLegsAnim( LEGS_IDLECR );
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1405
;1405:		}
LABELV $550
line 1407
;1406:		// airborne leaves position in cycle intact, but doesn't advance
;1407:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LEI4 $547
line 1408
;1408:			PM_ContinueLegsAnim( LEGS_SWIM );
CNSTI4 17
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1409
;1409:		}
line 1410
;1410:		return;
ADDRGP4 $547
JUMPV
LABELV $548
line 1414
;1411:	}
;1412:
;1413:	// if not trying to move
;1414:	if ( !pm->cmd.forwardmove && !pm->cmd.rightmove ) {
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
NEI4 $554
ADDRLP4 32
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
NEI4 $554
line 1415
;1415:		if (  pm->xyspeed < 5 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
CNSTF4 1084227584
GEF4 $547
line 1416
;1416:			pm->ps->bobCycle = 0;	// start at beginning of cycle again
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1417
;1417:			if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $558
line 1418
;1418:				PM_ContinueLegsAnim( LEGS_IDLECR );
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1419
;1419:			} else {
ADDRGP4 $547
JUMPV
LABELV $558
line 1420
;1420:				PM_ContinueLegsAnim( LEGS_IDLE );
CNSTI4 22
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1421
;1421:			}
line 1422
;1422:		}
line 1423
;1423:		return;
ADDRGP4 $547
JUMPV
LABELV $554
line 1427
;1424:	}
;1425:	
;1426:
;1427:	footstep = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1429
;1428:
;1429:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $560
line 1430
;1430:		bobmove = 0.5;	// ducked characters bob much faster
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1431
;1431:		if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $562
line 1432
;1432:			PM_ContinueLegsAnim( LEGS_BACKCR );
CNSTI4 32
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1433
;1433:		}
ADDRGP4 $561
JUMPV
LABELV $562
line 1434
;1434:		else {
line 1435
;1435:			PM_ContinueLegsAnim( LEGS_WALKCR );
CNSTI4 13
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1436
;1436:		}
line 1448
;1437:		// ducked characters never play footsteps
;1438:	/*
;1439:	} else 	if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
;1440:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
;1441:			bobmove = 0.4;	// faster speeds bob faster
;1442:			footstep = qtrue;
;1443:		} else {
;1444:			bobmove = 0.3;
;1445:		}
;1446:		PM_ContinueLegsAnim( LEGS_BACK );
;1447:	*/
;1448:	} else {
ADDRGP4 $561
JUMPV
LABELV $560
line 1449
;1449:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $564
line 1450
;1450:			bobmove = 0.4f;	// faster speeds bob faster
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 1451
;1451:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $566
line 1452
;1452:				PM_ContinueLegsAnim( LEGS_BACK );
CNSTI4 16
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1453
;1453:			}
ADDRGP4 $567
JUMPV
LABELV $566
line 1454
;1454:			else {
line 1455
;1455:				PM_ContinueLegsAnim( LEGS_RUN );
CNSTI4 15
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1456
;1456:			}
LABELV $567
line 1457
;1457:			footstep = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1458
;1458:		} else {
ADDRGP4 $565
JUMPV
LABELV $564
line 1459
;1459:			bobmove = 0.3f;	// walking bobs slow
ADDRLP4 4
CNSTF4 1050253722
ASGNF4
line 1460
;1460:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $568
line 1461
;1461:				PM_ContinueLegsAnim( LEGS_BACKWALK );
CNSTI4 33
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1462
;1462:			}
ADDRGP4 $569
JUMPV
LABELV $568
line 1463
;1463:			else {
line 1464
;1464:				PM_ContinueLegsAnim( LEGS_WALK );
CNSTI4 14
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1465
;1465:			}
LABELV $569
line 1466
;1466:		}
LABELV $565
line 1467
;1467:	}
LABELV $561
line 1470
;1468:
;1469:	// check for footstep / splash sounds
;1470:	old = pm->ps->bobCycle;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1471
;1471:	pm->ps->bobCycle = (int)( old + bobmove * pml.msec ) & 255;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
ADDRGP4 pml+40
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
CNSTI4 255
BANDI4
ASGNI4
line 1474
;1472:
;1473:	// if we just crossed a cycle boundary, play an apropriate footstep event
;1474:	if ( ( ( old + 64 ) ^ ( pm->ps->bobCycle + 64 ) ) & 128 ) {
ADDRLP4 40
CNSTI4 64
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
BXORI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $571
line 1475
;1475:		if ( pm->waterlevel == 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
NEI4 $573
line 1477
;1476:			// on ground will only play sounds if running
;1477:			if ( footstep && !pm->noFootsteps ) {
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $574
ADDRGP4 pm
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
NEI4 $574
line 1478
;1478:				PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 48
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1479
;1479:			}
line 1480
;1480:		} else if ( pm->waterlevel == 1 ) {
ADDRGP4 $574
JUMPV
LABELV $573
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
NEI4 $577
line 1482
;1481:			// splashing
;1482:			PM_AddEvent( EV_FOOTSPLASH );
CNSTI4 3
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1483
;1483:		} else if ( pm->waterlevel == 2 ) {
ADDRGP4 $578
JUMPV
LABELV $577
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 2
NEI4 $579
line 1485
;1484:			// wading / swimming at surface
;1485:			PM_AddEvent( EV_SWIM );
CNSTI4 5
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1486
;1486:		} else if ( pm->waterlevel == 3 ) {
ADDRGP4 $580
JUMPV
LABELV $579
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 3
NEI4 $581
line 1489
;1487:			// no sound when completely underwater
;1488:
;1489:		}
LABELV $581
LABELV $580
LABELV $578
LABELV $574
line 1490
;1490:	}
LABELV $571
line 1491
;1491:}
LABELV $547
endproc PM_Footsteps 52 4
proc PM_WaterEvents 16 4
line 1500
;1492:
;1493:/*
;1494:==============
;1495:PM_WaterEvents
;1496:
;1497:Generate sound events for entering and leaving water
;1498:==============
;1499:*/
;1500:static void PM_WaterEvents( void ) {		// FIXME?
line 1504
;1501:	//
;1502:	// if just entered a water volume, play a sound
;1503:	//
;1504:	if (!pml.previous_waterlevel && pm->waterlevel) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $584
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $584
line 1505
;1505:		PM_AddEvent( EV_WATER_TOUCH );
CNSTI4 16
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1506
;1506:	}
LABELV $584
line 1511
;1507:
;1508:	//
;1509:	// if just completely exited a water volume, play a sound
;1510:	//
;1511:	if (pml.previous_waterlevel && !pm->waterlevel) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $587
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $587
line 1512
;1512:		PM_AddEvent( EV_WATER_LEAVE );
CNSTI4 17
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1513
;1513:	}
LABELV $587
line 1518
;1514:
;1515:	//
;1516:	// check for head just going under water
;1517:	//
;1518:	if (pml.previous_waterlevel != 3 && pm->waterlevel == 3) {
ADDRLP4 8
CNSTI4 3
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $590
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $590
line 1519
;1519:		PM_AddEvent( EV_WATER_UNDER );
CNSTI4 18
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1520
;1520:	}
LABELV $590
line 1525
;1521:
;1522:	//
;1523:	// check for head just coming out of water
;1524:	//
;1525:	if (pml.previous_waterlevel == 3 && pm->waterlevel != 3) {
ADDRLP4 12
CNSTI4 3
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $593
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $593
line 1526
;1526:		PM_AddEvent( EV_WATER_CLEAR );
CNSTI4 19
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1527
;1527:	}
LABELV $593
line 1528
;1528:}
LABELV $583
endproc PM_WaterEvents 16 4
proc PM_BeginWeaponChange 8 4
line 1536
;1529:
;1530:
;1531:/*
;1532:===============
;1533:PM_BeginWeaponChange
;1534:===============
;1535:*/
;1536:static void PM_BeginWeaponChange( int weapon ) {
line 1537
;1537:	if ( weapon <= WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $599
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $597
LABELV $599
line 1538
;1538:		return;
ADDRGP4 $596
JUMPV
LABELV $597
line 1541
;1539:	}
;1540:
;1541:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $600
line 1542
;1542:		return;
ADDRGP4 $596
JUMPV
LABELV $600
line 1545
;1543:	}
;1544:	
;1545:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $602
line 1546
;1546:		return;
ADDRGP4 $596
JUMPV
LABELV $602
line 1549
;1547:	}
;1548:
;1549:	PM_AddEvent( EV_CHANGE_WEAPON );
CNSTI4 23
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1550
;1550:	pm->ps->weaponstate = WEAPON_DROPPING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 2
ASGNI4
line 1551
;1551:	pm->ps->weaponTime += 200;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1552
;1552:	PM_StartTorsoAnim( TORSO_DROP );
CNSTI4 9
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1553
;1553:}
LABELV $596
endproc PM_BeginWeaponChange 8 4
proc PM_FinishWeaponChange 12 4
line 1561
;1554:
;1555:
;1556:/*
;1557:===============
;1558:PM_FinishWeaponChange
;1559:===============
;1560:*/
;1561:static void PM_FinishWeaponChange( void ) {
line 1564
;1562:	int		weapon;
;1563:
;1564:	weapon = pm->cmd.weapon;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 1565
;1565:	if ( weapon < WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $607
ADDRLP4 0
INDIRI4
CNSTI4 12
LTI4 $605
LABELV $607
line 1566
;1566:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1567
;1567:	}
LABELV $605
line 1569
;1568:
;1569:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $608
line 1570
;1570:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1571
;1571:	}
LABELV $608
line 1573
;1572:
;1573:	pm->ps->weapon = weapon;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1574
;1574:	pm->ps->weaponstate = WEAPON_RAISING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1
ASGNI4
line 1575
;1575:	pm->ps->weaponTime += 250;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 250
ADDI4
ASGNI4
line 1576
;1576:	PM_StartTorsoAnim( TORSO_RAISE );
CNSTI4 10
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1577
;1577:}
LABELV $604
endproc PM_FinishWeaponChange 12 4
proc PM_TorsoAnimation 0 4
line 1586
;1578:
;1579:
;1580:/*
;1581:==============
;1582:PM_TorsoAnimation
;1583:
;1584:==============
;1585:*/
;1586:static void PM_TorsoAnimation( void ) {
line 1587
;1587:	if ( pm->ps->weaponstate == WEAPON_READY ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $611
line 1588
;1588:		if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $613
line 1589
;1589:			PM_ContinueTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1590
;1590:		} else {
ADDRGP4 $610
JUMPV
LABELV $613
line 1591
;1591:			PM_ContinueTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1592
;1592:		}
line 1593
;1593:		return;
LABELV $611
line 1595
;1594:	}
;1595:}
LABELV $610
endproc PM_TorsoAnimation 0 4
proc PM_Weapon 36 4
line 1605
;1596:
;1597:
;1598:/*
;1599:==============
;1600:PM_Weapon
;1601:
;1602:Generates weapon events and modifes the weapon counter
;1603:==============
;1604:*/
;1605:static void PM_Weapon( qboolean *finished ) {
line 1609
;1606:	int		addTime;
;1607:
;1608:	// don't allow attack until all buttons are up
;1609:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $616
line 1610
;1610:		return;
ADDRGP4 $615
JUMPV
LABELV $616
line 1614
;1611:	}
;1612:
;1613:	// ignore if spectator
;1614:	if ( pm->ps->persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $618
line 1615
;1615:		return;
ADDRGP4 $615
JUMPV
LABELV $618
line 1619
;1616:	}
;1617:
;1618:	// check for dead player
;1619:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $620
line 1620
;1620:		pm->ps->weapon = WP_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 1621
;1621:		return;
ADDRGP4 $615
JUMPV
LABELV $620
line 1652
;1622:	}
;1623:
;1624:	// MOVED TO G_ACTIVE.C
;1625:	// check for item using
;1626:	/*
;1627:	if ( pm->cmd.buttons & BUTTON_USE_HOLDABLE ) {
;1628:		if ( ! ( pm->ps->pm_flags & PMF_USE_ITEM_HELD ) ) {
;1629:			if (bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag == HI_MEDKIT
;1630:				&& pm->ps->stats[STAT_HEALTH] >= (pm->ps->stats[STAT_MAX_HEALTH] + 25)) {
;1631:				// don't use medkit if at max health
;1632:			}
;1633:			else {
;1634:				pm->ps->pm_flags |= PMF_USE_ITEM_HELD;
;1635:				PM_AddEvent( EV_USE_ITEM0 + bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag );
;1636:				if (bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag == HI_RECEPTACLE && finished == qfalse) {
;1637:					return;
;1638:				}
;1639:				else {
;1640:					pm->ps->stats[STAT_HOLDABLE_ITEM] = 0;
;1641:				}
;1642:			}
;1643:			return;
;1644:		}
;1645:	} else {
;1646:		pm->ps->pm_flags &= ~PMF_USE_ITEM_HELD;
;1647:	}
;1648:	*/
;1649:
;1650:
;1651:	// make weapon function
;1652:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $622
line 1653
;1653:		pm->ps->weaponTime -= pml.msec;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1654
;1654:	}
LABELV $622
line 1659
;1655:
;1656:	// check for weapon change
;1657:	// can't change if weapon is firing, but can change
;1658:	// again if lowering or raising
;1659:	if ( pm->ps->weaponTime <= 0 || pm->ps->weaponstate != WEAPON_FIRING ) {
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $627
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
EQI4 $625
LABELV $627
line 1660
;1660:		if ( pm->ps->weapon != pm->cmd.weapon ) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
EQI4 $628
line 1661
;1661:			PM_BeginWeaponChange( pm->cmd.weapon );
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 PM_BeginWeaponChange
CALLV
pop
line 1662
;1662:		}
LABELV $628
line 1663
;1663:	}
LABELV $625
line 1665
;1664:
;1665:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $630
line 1666
;1666:		return;
ADDRGP4 $615
JUMPV
LABELV $630
line 1670
;1667:	}
;1668:
;1669:	// change weapon if time
;1670:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $632
line 1671
;1671:		PM_FinishWeaponChange();
ADDRGP4 PM_FinishWeaponChange
CALLV
pop
line 1672
;1672:		return;
ADDRGP4 $615
JUMPV
LABELV $632
line 1675
;1673:	}
;1674:
;1675:	if ( pm->ps->weaponstate == WEAPON_RAISING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $634
line 1676
;1676:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1677
;1677:		if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $636
line 1678
;1678:			PM_StartTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1679
;1679:		} else {
ADDRGP4 $615
JUMPV
LABELV $636
line 1680
;1680:			PM_StartTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1681
;1681:		}
line 1682
;1682:		return;
ADDRGP4 $615
JUMPV
LABELV $634
line 1686
;1683:	}
;1684:
;1685:	// check for fire
;1686:	if ( ! (pm->cmd.buttons & BUTTON_ATTACK) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $638
line 1687
;1687:		pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1688
;1688:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1689
;1689:		return;
ADDRGP4 $615
JUMPV
LABELV $638
line 1693
;1690:	}
;1691:
;1692:	// start the animation even if out of ammo
;1693:	if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $640
line 1695
;1694:		// the guantlet only "fires" when it actually hits something
;1695:		if ( !pm->gauntletHit ) {
ADDRGP4 pm
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
NEI4 $642
line 1696
;1696:			pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1697
;1697:			pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1698
;1698:			return;
ADDRGP4 $615
JUMPV
LABELV $642
line 1700
;1699:		}
;1700:		PM_StartTorsoAnim( TORSO_ATTACK2 );
CNSTI4 8
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1701
;1701:	} else {
ADDRGP4 $641
JUMPV
LABELV $640
line 1702
;1702:		PM_StartTorsoAnim( TORSO_ATTACK );
CNSTI4 7
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1703
;1703:	}
LABELV $641
line 1705
;1704:
;1705:	pm->ps->weaponstate = WEAPON_FIRING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 3
ASGNI4
line 1708
;1706:
;1707:	// check for out of ammo
;1708:	if ( ! pm->ps->ammo[ pm->ps->weapon ] ) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $644
line 1709
;1709:		PM_AddEvent( EV_NOAMMO );
CNSTI4 22
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1710
;1710:		pm->ps->weaponTime += 500;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1711
;1711:		return;
ADDRGP4 $615
JUMPV
LABELV $644
line 1716
;1712:	}
;1713:
;1714:	// take an ammo away if not infinite
;1715:	// EMERALD: Also, don't take ammo away if we have the Conservation power-up
;1716:	if (pm->ps->ammo[pm->ps->weapon && pm->ps->powerups[PW_CONSERVATION]] != -1) {
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $649
ADDRLP4 16
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $649
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $650
JUMPV
LABELV $649
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $650
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $646
line 1717
;1717:		pm->ps->ammo[pm->ps->weapon]--;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1718
;1718:	}
LABELV $646
line 1721
;1719:
;1720:	// fire weapon
;1721:	PM_AddEvent( EV_FIRE_WEAPON );
CNSTI4 24
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1723
;1722:
;1723:	switch( pm->ps->weapon ) {
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 1
LTI4 $651
ADDRLP4 24
INDIRI4
CNSTI4 10
GTI4 $651
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $664-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $664
address $654
address $657
address $656
address $658
address $659
address $655
address $661
address $660
address $662
address $663
code
LABELV $651
LABELV $654
line 1726
;1724:	default:
;1725:	case WP_GAUNTLET:
;1726:		addTime = 400;
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1727
;1727:		break;
ADDRGP4 $652
JUMPV
LABELV $655
line 1729
;1728:	case WP_LIGHTNING:
;1729:		addTime = 50;
ADDRLP4 0
CNSTI4 50
ASGNI4
line 1730
;1730:		break;
ADDRGP4 $652
JUMPV
LABELV $656
line 1732
;1731:	case WP_SHOTGUN:
;1732:		addTime = 1000;
ADDRLP4 0
CNSTI4 1000
ASGNI4
line 1733
;1733:		break;
ADDRGP4 $652
JUMPV
LABELV $657
line 1735
;1734:	case WP_MACHINEGUN:
;1735:		addTime = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 1736
;1736:		break;
ADDRGP4 $652
JUMPV
LABELV $658
line 1738
;1737:	case WP_GRENADE_LAUNCHER:
;1738:		addTime = 800;
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1739
;1739:		break;
ADDRGP4 $652
JUMPV
LABELV $659
line 1741
;1740:	case WP_ROCKET_LAUNCHER:
;1741:		addTime = 800;
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1742
;1742:		break;
ADDRGP4 $652
JUMPV
LABELV $660
line 1744
;1743:	case WP_PLASMAGUN:
;1744:		addTime = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 1745
;1745:		break;
ADDRGP4 $652
JUMPV
LABELV $661
line 1747
;1746:	case WP_RAILGUN:
;1747:		addTime = 1500;
ADDRLP4 0
CNSTI4 1500
ASGNI4
line 1748
;1748:		break;
ADDRGP4 $652
JUMPV
LABELV $662
line 1750
;1749:	case WP_BFG:
;1750:		addTime = 200;
ADDRLP4 0
CNSTI4 200
ASGNI4
line 1751
;1751:		break;
ADDRGP4 $652
JUMPV
LABELV $663
line 1753
;1752:	case WP_GRAPPLING_HOOK:
;1753:		addTime = 400;
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1754
;1754:		break;
LABELV $652
line 1778
;1755:#ifdef MISSIONPACK
;1756:	case WP_NAILGUN:
;1757:		addTime = 1000;
;1758:		break;
;1759:	case WP_PROX_LAUNCHER:
;1760:		addTime = 800;
;1761:		break;
;1762:	case WP_CHAINGUN:
;1763:		addTime = 30;
;1764:		break;
;1765:#endif
;1766:	}
;1767:
;1768:#ifdef MISSIONPACK
;1769:	if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
;1770:		addTime /= 1.5;
;1771:	}
;1772:	else
;1773:	if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
;1774:		addTime /= 1.3;
;1775:  }
;1776:  else
;1777:#endif
;1778:	if ( pm->ps->powerups[PW_HASTE] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $666
line 1779
;1779:		addTime /= 1.3;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1067869798
DIVF4
CVFI4 4
ASGNI4
line 1780
;1780:	}
LABELV $666
line 1782
;1781:
;1782:	pm->ps->weaponTime += addTime;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 1783
;1783:}
LABELV $615
endproc PM_Weapon 36 4
proc PM_Animate 0 4
line 1791
;1784:
;1785:/*
;1786:================
;1787:PM_Animate
;1788:================
;1789:*/
;1790:
;1791:static void PM_Animate( void ) {
line 1792
;1792:	if ( pm->cmd.buttons & BUTTON_GESTURE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $669
line 1793
;1793:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $671
line 1794
;1794:			PM_StartTorsoAnim( TORSO_GESTURE );
CNSTI4 6
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1795
;1795:			pm->ps->torsoTimer = TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 2294
ASGNI4
line 1796
;1796:			PM_AddEvent( EV_TAUNT );
CNSTI4 94
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1797
;1797:		}
LABELV $671
line 1830
;1798:#ifdef MISSIONPACK
;1799:	} else if ( pm->cmd.buttons & BUTTON_GETFLAG ) {
;1800:		if ( pm->ps->torsoTimer == 0 ) {
;1801:			PM_StartTorsoAnim( TORSO_GETFLAG );
;1802:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1803:		}
;1804:	} else if ( pm->cmd.buttons & BUTTON_GUARDBASE ) {
;1805:		if ( pm->ps->torsoTimer == 0 ) {
;1806:			PM_StartTorsoAnim( TORSO_GUARDBASE );
;1807:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1808:		}
;1809:	} else if ( pm->cmd.buttons & BUTTON_PATROL ) {
;1810:		if ( pm->ps->torsoTimer == 0 ) {
;1811:			PM_StartTorsoAnim( TORSO_PATROL );
;1812:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1813:		}
;1814:	} else if ( pm->cmd.buttons & BUTTON_FOLLOWME ) {
;1815:		if ( pm->ps->torsoTimer == 0 ) {
;1816:			PM_StartTorsoAnim( TORSO_FOLLOWME );
;1817:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1818:		}
;1819:	} else if ( pm->cmd.buttons & BUTTON_AFFIRMATIVE ) {
;1820:		if ( pm->ps->torsoTimer == 0 ) {
;1821:			PM_StartTorsoAnim( TORSO_AFFIRMATIVE);
;1822:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1823:		}
;1824:	} else if ( pm->cmd.buttons & BUTTON_NEGATIVE ) {
;1825:		if ( pm->ps->torsoTimer == 0 ) {
;1826:			PM_StartTorsoAnim( TORSO_NEGATIVE );
;1827:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1828:		}
;1829:#endif
;1830:	}
LABELV $669
line 1831
;1831:}
LABELV $668
endproc PM_Animate 0 4
proc PM_DropTimers 4 0
line 1839
;1832:
;1833:
;1834:/*
;1835:================
;1836:PM_DropTimers
;1837:================
;1838:*/
;1839:static void PM_DropTimers( void ) {
line 1841
;1840:	// drop misc timing counter
;1841:	if ( pm->ps->pm_time ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $674
line 1842
;1842:		if ( pml.msec >= pm->ps->pm_time ) {
ADDRGP4 pml+40
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $676
line 1843
;1843:			pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 1844
;1844:			pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1845
;1845:		} else {
ADDRGP4 $677
JUMPV
LABELV $676
line 1846
;1846:			pm->ps->pm_time -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1847
;1847:		}
LABELV $677
line 1848
;1848:	}
LABELV $674
line 1851
;1849:
;1850:	// drop animation counter
;1851:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $680
line 1852
;1852:		pm->ps->legsTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1853
;1853:		if ( pm->ps->legsTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
GEI4 $683
line 1854
;1854:			pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 1855
;1855:		}
LABELV $683
line 1856
;1856:	}
LABELV $680
line 1858
;1857:
;1858:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $685
line 1859
;1859:		pm->ps->torsoTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1860
;1860:		if ( pm->ps->torsoTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
GEI4 $688
line 1861
;1861:			pm->ps->torsoTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 0
ASGNI4
line 1862
;1862:		}
LABELV $688
line 1863
;1863:	}
LABELV $685
line 1864
;1864:}
LABELV $673
endproc PM_DropTimers 4 0
export PM_UpdateViewAngles
proc PM_UpdateViewAngles 24 0
line 1885
;1865:
;1866:/*
;1867:================
;1868:PM_UpdateUbers
;1869:
;1870:================
;1871:*/
;1872:/* void PM_Ubers( playerState_t *ps ) {
;1873:	ps->eFlags |= EF_UW_SHOTGUN;
;1874:	Com_Printf("%i \n", ps->eFlags & EF_UW_SHOTGUN);
;1875:} */
;1876:
;1877:/*
;1878:================
;1879:PM_UpdateViewAngles
;1880:
;1881:This can be used as another entry point when only the viewangles
;1882:are being updated isntead of a full move
;1883:================
;1884:*/
;1885:void PM_UpdateViewAngles(playerState_t *ps, const usercmd_t *cmd, qboolean *upsideDown) {
line 1889
;1886:	short		temp;
;1887:	int		i;
;1888:
;1889:	if (ps->pm_type == PM_INTERMISSION || ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
EQI4 $693
ADDRLP4 8
INDIRI4
CNSTI4 6
NEI4 $691
LABELV $693
line 1890
;1890:		return;		// no view changes at all
ADDRGP4 $690
JUMPV
LABELV $691
line 1893
;1891:	}
;1892:
;1893:	if (ps->pm_type != PM_SPECTATOR && ps->stats[STAT_HEALTH] <= 0) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $694
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $694
line 1894
;1894:		return;		// no view changes at all
ADDRGP4 $690
JUMPV
LABELV $694
line 1898
;1895:	}
;1896:
;1897:	// circularly clamp the angles with deltas
;1898:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $696
line 1899
;1899:		temp = cmd->angles[i] + ps->delta_angles[i];
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
INDIRI4
ADDI4
CVII2 4
ASGNI2
line 1900
;1900:		if (i == PITCH) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $700
line 1902
;1901:			// don't let the player look up or down more than 90 degrees
;1902:			if (temp > 16000) {
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 16000
LEI4 $702
line 1903
;1903:				ps->delta_angles[i] = 16000 - cmd->angles[i];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 16000
ADDRLP4 20
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1904
;1904:				temp = 16000;
ADDRLP4 4
CNSTI2 16000
ASGNI2
line 1905
;1905:			}
ADDRGP4 $703
JUMPV
LABELV $702
line 1906
;1906:			else if (temp < -16000) {
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 -16000
GEI4 $704
line 1907
;1907:				ps->delta_angles[i] = -16000 - cmd->angles[i];
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 -16000
ADDRLP4 20
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1908
;1908:				temp = -16000;
ADDRLP4 4
CNSTI2 -16000
ASGNI2
line 1909
;1909:			}
LABELV $704
LABELV $703
line 1910
;1910:		}
LABELV $700
line 1924
;1911:		// EMERALD
;1912:		/* if (upsideDown) {
;1913:			ps->viewangles[i] = SHORT2ANGLE(temp);
;1914:			ps->viewangles[ROLL] = 180;
;1915:			Com_Printf("eee");
;1916:		}
;1917:		else {
;1918:			ps->viewangles[i] = SHORT2ANGLE(temp) * -1;
;1919:			ps->viewangles[ROLL] = 0;
;1920:		}
;1921:		ps->viewangles[i] = SHORT2ANGLE(temp); */
;1922:
;1923:		// EMERALD: Inverted gravity viewangles
;1924:		if (ps->eFlags & EF_UPSIDEDOWN) {
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 4194304
BANDI4
CNSTI4 0
EQI4 $706
line 1925
;1925:			ps->viewangles[i] = SHORT2ANGLE(temp) * -1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ADDP4
CNSTF4 3212836864
CNSTF4 1001652224
ADDRLP4 4
INDIRI2
CVII4 2
CVIF4 4
MULF4
MULF4
ASGNF4
line 1926
;1926:			ps->viewangles[ROLL] = 180;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTF4 1127481344
ASGNF4
line 1928
;1927:			// Com_Printf("eee");
;1928:		}
ADDRGP4 $707
JUMPV
LABELV $706
line 1929
;1929:		else {
line 1930
;1930:			ps->viewangles[i] = SHORT2ANGLE(temp);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ADDP4
CNSTF4 1001652224
ADDRLP4 4
INDIRI2
CVII4 2
CVIF4 4
MULF4
ASGNF4
line 1931
;1931:			ps->viewangles[ROLL] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTF4 0
ASGNF4
line 1932
;1932:		}
LABELV $707
line 1933
;1933:	}
LABELV $697
line 1898
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $696
line 1935
;1934:
;1935:}
LABELV $690
endproc PM_UpdateViewAngles 24 0
export PmoveSingle
proc PmoveSingle 64 16
line 1946
;1936:
;1937:
;1938:/*
;1939:================
;1940:PmoveSingle
;1941:
;1942:================
;1943:*/
;1944:void trap_SnapVector( float *v );
;1945:
;1946:void PmoveSingle (pmove_t *pmove, qboolean maxweaps, qboolean *upsideDown, qboolean *finished) {
line 1947
;1947:	pm = pmove;
ADDRGP4 pm
ADDRFP4 0
INDIRP4
ASGNP4
line 1951
;1948:
;1949:	// this counter lets us debug movement problems with a journal
;1950:	// by setting a conditional breakpoint fot the previous frame
;1951:	c_pmove++;
ADDRLP4 0
ADDRGP4 c_pmove
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1954
;1952:
;1953:	// clear results
;1954:	pm->numtouch = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1955
;1955:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 1956
;1956:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 0
ASGNI4
line 1958
;1957:
;1958:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $709
line 1959
;1959:		pm->tracemask &= ~CONTENTS_BODY;	// corpses can fly through bodies
ADDRLP4 4
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 1960
;1960:	}
LABELV $709
line 1964
;1961:
;1962:	// make sure walking button is clear if they are running, to avoid
;1963:	// proxy no-footsteps cheats
;1964:	if ( abs( pm->cmd.forwardmove ) > 64 || abs( pm->cmd.rightmove ) > 64 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
GTI4 $713
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LEI4 $711
LABELV $713
line 1965
;1965:		pm->cmd.buttons &= ~BUTTON_WALKING;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 1966
;1966:	}
LABELV $711
line 1969
;1967:
;1968:	// set the talk balloon flag
;1969:	if ( pm->cmd.buttons & BUTTON_TALK ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $714
line 1970
;1970:		pm->ps->eFlags |= EF_TALK;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1971
;1971:	} else {
ADDRGP4 $715
JUMPV
LABELV $714
line 1972
;1972:		pm->ps->eFlags &= ~EF_TALK;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 1973
;1973:	}
LABELV $715
line 1979
;1974:
;1975:	// UBER ARENA TEST
;1976:	// Com_Printf("deus ex");
;1977:
;1978:	// set the firing flag for continuous beam weapons
;1979:	if ( !(pm->ps->pm_flags & PMF_RESPAWNED) && pm->ps->pm_type != PM_INTERMISSION
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
ADDRLP4 20
INDIRI4
NEI4 $716
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $716
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 20
INDIRI4
EQI4 $716
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $716
line 1980
;1980:		&& ( pm->cmd.buttons & BUTTON_ATTACK ) && pm->ps->ammo[ pm->ps->weapon ] ) {
line 1981
;1981:		pm->ps->eFlags |= EF_FIRING;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 1982
;1982:	} else {
ADDRGP4 $717
JUMPV
LABELV $716
line 1983
;1983:		pm->ps->eFlags &= ~EF_FIRING;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 1984
;1984:	}
LABELV $717
line 1988
;1985:
;1986:	// UBER ARENA TEST
;1987:
;1988:	if (pm->ps->stats[STAT_UBERS] & UW_SHOTGUN) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $718
line 1989
;1989:		pm->ps->eFlags |= EF_UW_SHOTGUN;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 16777216
BORI4
ASGNI4
line 1990
;1990:	}
LABELV $718
line 1992
;1991:
;1992:	if (pm->ps->stats[STAT_UBERS] & UW_ROCKET) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $720
line 1993
;1993:		pm->ps->eFlags |= EF_AWARD_DENIED;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 262144
BORI4
ASGNI4
line 1994
;1994:	}
LABELV $720
line 1997
;1995:
;1996:	// clear the respawned flag if attack and use are cleared
;1997:	if ( pm->ps->stats[STAT_HEALTH] > 0 && 
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $722
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 5
BANDI4
ADDRLP4 28
INDIRI4
NEI4 $722
line 1998
;1998:		!( pm->cmd.buttons & (BUTTON_ATTACK | BUTTON_USE_HOLDABLE) ) ) {
line 1999
;1999:		pm->ps->pm_flags &= ~PMF_RESPAWNED;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 2000
;2000:	}
LABELV $722
line 2002
;2001:
;2002:	if (maxweaps == qtrue)
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $724
line 2003
;2003:		pm->ps->eFlags |= EF_MAXWEAPS;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 2097152
BORI4
ASGNI4
ADDRGP4 $725
JUMPV
LABELV $724
line 2005
;2004:	else
;2005:		pm->ps->eFlags &= ~EF_MAXWEAPS;
ADDRLP4 36
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 -2097153
BANDI4
ASGNI4
LABELV $725
line 2010
;2006:
;2007:	// if talk button is down, dissallow all other input
;2008:	// this is to prevent any possible intercept proxy from
;2009:	// adding fake talk balloons
;2010:	if ( pmove->cmd.buttons & BUTTON_TALK ) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $726
line 2013
;2011:		// keep the talk button set tho for when the cmd.serverTime > 66 msec
;2012:		// and the same cmd is used multiple times in Pmove
;2013:		pmove->cmd.buttons = BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 2
ASGNI4
line 2014
;2014:		pmove->cmd.forwardmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 2015
;2015:		pmove->cmd.rightmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 2016
;2016:		pmove->cmd.upmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 2017
;2017:	}
LABELV $726
line 2020
;2018:
;2019:	// clear all pmove local vars
;2020:	memset (&pml, 0, sizeof(pml));
ADDRGP4 pml
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2023
;2021:
;2022:	// determine the time
;2023:	pml.msec = pmove->cmd.serverTime - pm->ps->commandTime;
ADDRGP4 pml+40
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 2024
;2024:	if ( pml.msec < 1 ) {
ADDRGP4 pml+40
INDIRI4
CNSTI4 1
GEI4 $729
line 2025
;2025:		pml.msec = 1;
ADDRGP4 pml+40
CNSTI4 1
ASGNI4
line 2026
;2026:	} else if ( pml.msec > 200 ) {
ADDRGP4 $730
JUMPV
LABELV $729
ADDRGP4 pml+40
INDIRI4
CNSTI4 200
LEI4 $733
line 2027
;2027:		pml.msec = 200;
ADDRGP4 pml+40
CNSTI4 200
ASGNI4
line 2028
;2028:	}
LABELV $733
LABELV $730
line 2029
;2029:	pm->ps->commandTime = pmove->cmd.serverTime;
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2032
;2030:
;2031:	// save old org in case we get stuck
;2032:	VectorCopy (pm->ps->origin, pml.previous_origin);
ADDRGP4 pml+112
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2035
;2033:
;2034:	// save old velocity for crashlanding
;2035:	VectorCopy (pm->ps->velocity, pml.previous_velocity);
ADDRGP4 pml+124
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 2037
;2036:
;2037:	pml.frametime = pml.msec * 0.001;
ADDRGP4 pml+36
CNSTF4 981668463
ADDRGP4 pml+40
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 2040
;2038:
;2039:	// update the viewangles
;2040:	PM_UpdateViewAngles( pm->ps, &pm->cmd, upsideDown );
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 2042
;2041:
;2042:	AngleVectors (pm->ps->viewangles, pml.forward, pml.right, pml.up);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 pml
ARGP4
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+24
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2044
;2043:
;2044:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $743
line 2046
;2045:		// not holding jump
;2046:		pm->ps->pm_flags &= ~PMF_JUMP_HELD;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2047
;2047:	}
LABELV $743
line 2050
;2048:
;2049:	// decide if backpedaling animations should be used
;2050:	if ( pm->cmd.forwardmove < 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $745
line 2051
;2051:		pm->ps->pm_flags |= PMF_BACKWARDS_RUN;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 2052
;2052:	} else if ( pm->cmd.forwardmove > 0 || ( pm->cmd.forwardmove == 0 && pm->cmd.rightmove ) ) {
ADDRGP4 $746
JUMPV
LABELV $745
ADDRLP4 44
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRI4
GTI4 $749
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRI4
NEI4 $747
ADDRLP4 44
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
EQI4 $747
LABELV $749
line 2053
;2053:		pm->ps->pm_flags &= ~PMF_BACKWARDS_RUN;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2054
;2054:	}
LABELV $747
LABELV $746
line 2056
;2055:
;2056:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $750
line 2057
;2057:		pm->cmd.forwardmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 2058
;2058:		pm->cmd.rightmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 2059
;2059:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 2060
;2060:	}
LABELV $750
line 2062
;2061:
;2062:	if ( pm->ps->pm_type == PM_SPECTATOR ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $752
line 2063
;2063:		PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 2064
;2064:		PM_FlyMove ();
ADDRGP4 PM_FlyMove
CALLV
pop
line 2065
;2065:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2066
;2066:		return;
ADDRGP4 $708
JUMPV
LABELV $752
line 2069
;2067:	}
;2068:
;2069:	if ( pm->ps->pm_type == PM_NOCLIP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $754
line 2070
;2070:		PM_NoclipMove ();
ADDRGP4 PM_NoclipMove
CALLV
pop
line 2071
;2071:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2072
;2072:		return;
ADDRGP4 $708
JUMPV
LABELV $754
line 2075
;2073:	}
;2074:
;2075:	if (pm->ps->pm_type == PM_FREEZE) {
ADDRLP4 56
CNSTI4 4
ASGNI4
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $756
line 2076
;2076:		return;		// no movement at all
ADDRGP4 $708
JUMPV
LABELV $756
line 2079
;2077:	}
;2078:
;2079:	if ( pm->ps->pm_type == PM_INTERMISSION || pm->ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 5
EQI4 $760
ADDRLP4 60
INDIRI4
CNSTI4 6
NEI4 $758
LABELV $760
line 2080
;2080:		return;		// no movement at all
ADDRGP4 $708
JUMPV
LABELV $758
line 2084
;2081:	}
;2082:
;2083:	// set watertype, and waterlevel
;2084:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 2085
;2085:	pml.previous_waterlevel = pmove->waterlevel;
ADDRGP4 pml+136
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 2088
;2086:
;2087:	// set mins, maxs, and viewheight
;2088:	PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 2091
;2089:
;2090:	// set groundentity
;2091:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 2093
;2092:
;2093:	if ( pm->ps->pm_type == PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $762
line 2094
;2094:		PM_DeadMove ();
ADDRGP4 PM_DeadMove
CALLV
pop
line 2095
;2095:	}
LABELV $762
line 2097
;2096:
;2097:	PM_DropTimers();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2104
;2098:
;2099:#ifdef MISSIONPACK
;2100:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
;2101:		PM_InvulnerabilityMove();
;2102:	} else
;2103:#endif
;2104:	if ( pm->ps->powerups[PW_FLIGHT] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $764
line 2106
;2105:		// flight powerup doesn't allow jump and has different friction
;2106:		PM_FlyMove();
ADDRGP4 PM_FlyMove
CALLV
pop
line 2107
;2107:	} else if (pm->ps->pm_flags & PMF_GRAPPLE_PULL) {
ADDRGP4 $765
JUMPV
LABELV $764
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $766
line 2108
;2108:		PM_GrappleMove();
ADDRGP4 PM_GrappleMove
CALLV
pop
line 2110
;2109:		// We can wiggle a bit
;2110:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 2111
;2111:	} else if (pm->ps->pm_flags & PMF_TIME_WATERJUMP) {
ADDRGP4 $767
JUMPV
LABELV $766
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $768
line 2112
;2112:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 2113
;2113:	} else if ( pm->waterlevel > 1 ) {
ADDRGP4 $769
JUMPV
LABELV $768
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LEI4 $770
line 2115
;2114:		// swimming
;2115:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 2116
;2116:	} else if ( pml.walking ) {
ADDRGP4 $771
JUMPV
LABELV $770
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $772
line 2118
;2117:		// walking on ground
;2118:		PM_WalkMove();
ADDRGP4 PM_WalkMove
CALLV
pop
line 2119
;2119:	} else {
ADDRGP4 $773
JUMPV
LABELV $772
line 2121
;2120:		// airborne
;2121:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 2122
;2122:	}
LABELV $773
LABELV $771
LABELV $769
LABELV $767
LABELV $765
line 2124
;2123:
;2124:	PM_Animate();
ADDRGP4 PM_Animate
CALLV
pop
line 2127
;2125:
;2126:	// set groundentity, watertype, and waterlevel
;2127:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 2128
;2128:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 2131
;2129:
;2130:	// weapons
;2131:	PM_Weapon(finished);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 PM_Weapon
CALLV
pop
line 2134
;2132:
;2133:	// torso animation
;2134:	PM_TorsoAnimation();
ADDRGP4 PM_TorsoAnimation
CALLV
pop
line 2137
;2135:
;2136:	// footstep events / legs animations
;2137:	PM_Footsteps();
ADDRGP4 PM_Footsteps
CALLV
pop
line 2140
;2138:
;2139:	// entering / leaving water splashes
;2140:	PM_WaterEvents();
ADDRGP4 PM_WaterEvents
CALLV
pop
line 2143
;2141:
;2142:	// snap some parts of playerstate to save network bandwidth
;2143:	trap_SnapVector( pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 trap_SnapVector
CALLV
pop
line 2144
;2144:}
LABELV $708
endproc PmoveSingle 64 16
export Pmove
proc Pmove 16 16
line 2154
;2145:
;2146:
;2147:/*
;2148:================
;2149:Pmove
;2150:
;2151:Can be called by either the server or the client
;2152:================
;2153:*/
;2154:void Pmove (pmove_t *pmove, qboolean maxweaps, qboolean *upsideDown, qboolean *finished) {
line 2157
;2155:	int			finalTime;
;2156:
;2157:	finalTime = pmove->cmd.serverTime;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2159
;2158:
;2159:	if ( finalTime < pmove->ps->commandTime ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
GEI4 $776
line 2160
;2160:		return;	// should not happen
ADDRGP4 $775
JUMPV
LABELV $776
line 2163
;2161:	}
;2162:
;2163:	if ( finalTime > pmove->ps->commandTime + 1000 ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $778
line 2164
;2164:		pmove->ps->commandTime = finalTime - 1000;
ADDRFP4 0
INDIRP4
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 2165
;2165:	}
LABELV $778
line 2167
;2166:
;2167:	pmove->ps->pmove_framecount = (pmove->ps->pmove_framecount+1) & ((1<<PS_PMOVEFRAMECOUNTBITS)-1);
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 456
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 63
BANDI4
ASGNI4
ADDRGP4 $781
JUMPV
LABELV $780
line 2171
;2168:
;2169:	// chop the move up if it is too long, to prevent framerate
;2170:	// dependent behavior
;2171:	while ( pmove->ps->commandTime != finalTime ) {
line 2174
;2172:		int		msec;
;2173:
;2174:		msec = finalTime - pmove->ps->commandTime;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 2176
;2175:
;2176:		if ( pmove->pmove_fixed ) {
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 0
EQI4 $783
line 2177
;2177:			if ( msec > pmove->pmove_msec ) {
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
LEI4 $784
line 2178
;2178:				msec = pmove->pmove_msec;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ASGNI4
line 2179
;2179:			}
line 2180
;2180:		}
ADDRGP4 $784
JUMPV
LABELV $783
line 2181
;2181:		else {
line 2182
;2182:			if ( msec > 66 ) {
ADDRLP4 8
INDIRI4
CNSTI4 66
LEI4 $787
line 2183
;2183:				msec = 66;
ADDRLP4 8
CNSTI4 66
ASGNI4
line 2184
;2184:			}
LABELV $787
line 2185
;2185:		}
LABELV $784
line 2186
;2186:		pmove->cmd.serverTime = pmove->ps->commandTime + msec;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 2187
;2187:		PmoveSingle( pmove, maxweaps, upsideDown, finished );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 PmoveSingle
CALLV
pop
line 2189
;2188:
;2189:		if ( pmove->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $789
line 2190
;2190:			pmove->cmd.upmove = 20;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 20
ASGNI1
line 2191
;2191:		}
LABELV $789
line 2192
;2192:	}
LABELV $781
line 2171
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $780
line 2196
;2193:
;2194:	//PM_CheckStuck();
;2195:
;2196:}
LABELV $775
endproc Pmove 16 16
import trap_SnapVector
import PM_StepSlideMove
import PM_SlideMove
bss
export pml
align 4
LABELV pml
skip 140
export pm
align 4
LABELV pm
skip 4
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
LABELV $507
byte 1 37
byte 1 105
byte 1 58
byte 1 76
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $496
byte 1 37
byte 1 105
byte 1 58
byte 1 115
byte 1 116
byte 1 101
byte 1 101
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $485
byte 1 37
byte 1 105
byte 1 58
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 111
byte 1 102
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $454
byte 1 37
byte 1 105
byte 1 58
byte 1 108
byte 1 105
byte 1 102
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $427
byte 1 37
byte 1 105
byte 1 58
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $407
byte 1 68
byte 1 105
byte 1 102
byte 1 102
byte 1 101
byte 1 114
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 10
byte 1 0
