data
export drawTeamOverlayModificationCount
align 4
LABELV drawTeamOverlayModificationCount
byte 4 -1
code
proc CG_DrawField 64 20
file "../cg_draw.c"
line 212
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
;23:// cg_draw.c -- draw all of the graphical elements during
;24:// active (after loading) gameplay
;25:
;26:#include "cg_local.h"
;27:
;28:#ifdef MISSIONPACK
;29:#include "../ui/ui_shared.h"
;30:
;31:// used for scoreboard
;32:extern displayContextDef_t cgDC;
;33:menuDef_t *menuScoreboard = NULL;
;34:#else
;35:int drawTeamOverlayModificationCount = -1;
;36:#endif
;37:
;38:int sortedTeamPlayers[TEAM_MAXOVERLAY];
;39:int	numSortedTeamPlayers;
;40:
;41:char systemChat[256];
;42:char teamChat1[256];
;43:char teamChat2[256];
;44:
;45:#ifdef MISSIONPACK
;46:
;47:int CG_Text_Width(const char *text, float scale, int limit) {
;48:  int count,len;
;49:	float out;
;50:	glyphInfo_t *glyph;
;51:	float useScale;
;52:// FIXME: see ui_main.c, same problem
;53://	const unsigned char *s = text;
;54:	const char *s = text;
;55:	fontInfo_t *font = &cgDC.Assets.textFont;
;56:	if (scale <= cg_smallFont.value) {
;57:		font = &cgDC.Assets.smallFont;
;58:	} else if (scale > cg_bigFont.value) {
;59:		font = &cgDC.Assets.bigFont;
;60:	}
;61:	useScale = scale * font->glyphScale;
;62:  out = 0;
;63:  if (text) {
;64:    len = strlen(text);
;65:		if (limit > 0 && len > limit) {
;66:			len = limit;
;67:		}
;68:		count = 0;
;69:		while (s && *s && count < len) {
;70:			if ( Q_IsColorString(s) ) {
;71:				s += 2;
;72:				continue;
;73:			} else {
;74:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;75:				out += glyph->xSkip;
;76:				s++;
;77:				count++;
;78:			}
;79:    }
;80:  }
;81:  return out * useScale;
;82:}
;83:
;84:int CG_Text_Height(const char *text, float scale, int limit) {
;85:  int len, count;
;86:	float max;
;87:	glyphInfo_t *glyph;
;88:	float useScale;
;89:// TTimo: FIXME
;90://	const unsigned char *s = text;
;91:	const char *s = text;
;92:	fontInfo_t *font = &cgDC.Assets.textFont;
;93:	if (scale <= cg_smallFont.value) {
;94:		font = &cgDC.Assets.smallFont;
;95:	} else if (scale > cg_bigFont.value) {
;96:		font = &cgDC.Assets.bigFont;
;97:	}
;98:	useScale = scale * font->glyphScale;
;99:  max = 0;
;100:  if (text) {
;101:    len = strlen(text);
;102:		if (limit > 0 && len > limit) {
;103:			len = limit;
;104:		}
;105:		count = 0;
;106:		while (s && *s && count < len) {
;107:			if ( Q_IsColorString(s) ) {
;108:				s += 2;
;109:				continue;
;110:			} else {
;111:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;112:	      if (max < glyph->height) {
;113:		      max = glyph->height;
;114:			  }
;115:				s++;
;116:				count++;
;117:			}
;118:    }
;119:  }
;120:  return max * useScale;
;121:}
;122:
;123:void CG_Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
;124:  float w, h;
;125:  w = width * scale;
;126:  h = height * scale;
;127:  CG_AdjustFrom640( &x, &y, &w, &h );
;128:  trap_R_DrawStretchPic( x, y, w, h, s, t, s2, t2, hShader );
;129:}
;130:
;131:void CG_Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style) {
;132:  int len, count;
;133:	vec4_t newColor;
;134:	glyphInfo_t *glyph;
;135:	float useScale;
;136:	fontInfo_t *font = &cgDC.Assets.textFont;
;137:	if (scale <= cg_smallFont.value) {
;138:		font = &cgDC.Assets.smallFont;
;139:	} else if (scale > cg_bigFont.value) {
;140:		font = &cgDC.Assets.bigFont;
;141:	}
;142:	useScale = scale * font->glyphScale;
;143:  if (text) {
;144:// TTimo: FIXME
;145://		const unsigned char *s = text;
;146:		const char *s = text;
;147:		trap_R_SetColor( color );
;148:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
;149:    len = strlen(text);
;150:		if (limit > 0 && len > limit) {
;151:			len = limit;
;152:		}
;153:		count = 0;
;154:		while (s && *s && count < len) {
;155:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;156:      //int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;157:      //float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;158:			if ( Q_IsColorString( s ) ) {
;159:				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
;160:				newColor[3] = color[3];
;161:				trap_R_SetColor( newColor );
;162:				s += 2;
;163:				continue;
;164:			} else {
;165:				float yadj = useScale * glyph->top;
;166:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
;167:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
;168:					colorBlack[3] = newColor[3];
;169:					trap_R_SetColor( colorBlack );
;170:					CG_Text_PaintChar(x + ofs, y - yadj + ofs, 
;171:														glyph->imageWidth,
;172:														glyph->imageHeight,
;173:														useScale, 
;174:														glyph->s,
;175:														glyph->t,
;176:														glyph->s2,
;177:														glyph->t2,
;178:														glyph->glyph);
;179:					colorBlack[3] = 1.0;
;180:					trap_R_SetColor( newColor );
;181:				}
;182:				CG_Text_PaintChar(x, y - yadj, 
;183:													glyph->imageWidth,
;184:													glyph->imageHeight,
;185:													useScale, 
;186:													glyph->s,
;187:													glyph->t,
;188:													glyph->s2,
;189:													glyph->t2,
;190:													glyph->glyph);
;191:				// CG_DrawPic(x, y - yadj, scale * cgDC.Assets.textFont.glyphs[text[i]].imageWidth, scale * cgDC.Assets.textFont.glyphs[text[i]].imageHeight, cgDC.Assets.textFont.glyphs[text[i]].glyph);
;192:				x += (glyph->xSkip * useScale) + adjust;
;193:				s++;
;194:				count++;
;195:			}
;196:    }
;197:	  trap_R_SetColor( NULL );
;198:  }
;199:}
;200:
;201:
;202:#endif
;203:
;204:/*
;205:==============
;206:CG_DrawField
;207:
;208:Draws large numbers for status bar and powerups
;209:==============
;210:*/
;211:#ifndef MISSIONPACK
;212:static void CG_DrawField (int x, int y, int width, int value, int char_width, int char_height) {
line 220
;213:	char	num[16], *ptr;
;214:	int		l;
;215:	int		frame;
;216:
;217:	// EMERALD
;218:	// 32 and 48 for all status bar numbers except weapon limits
;219:
;220:	if ( width < 1 ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $71
line 221
;221:		return;
ADDRGP4 $70
JUMPV
LABELV $71
line 225
;222:	}
;223:
;224:	// draw number string
;225:	if ( width > 5 ) {
ADDRFP4 8
INDIRI4
CNSTI4 5
LEI4 $73
line 226
;226:		width = 5;
ADDRFP4 8
CNSTI4 5
ASGNI4
line 227
;227:	}
LABELV $73
line 229
;228:
;229:	switch ( width ) {
ADDRLP4 28
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
LTI4 $75
ADDRLP4 28
INDIRI4
CNSTI4 4
GTI4 $75
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $105-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $105
address $77
address $84
address $91
address $98
code
LABELV $77
line 231
;230:	case 1:
;231:		value = value > 9 ? 9 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9
LEI4 $79
ADDRLP4 32
CNSTI4 9
ASGNI4
ADDRGP4 $80
JUMPV
LABELV $79
ADDRLP4 32
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $80
ADDRFP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 232
;232:		value = value < 0 ? 0 : value;
ADDRFP4 12
INDIRI4
CNSTI4 0
GEI4 $82
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 $83
JUMPV
LABELV $82
ADDRLP4 36
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $83
ADDRFP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 233
;233:		break;
ADDRGP4 $76
JUMPV
LABELV $84
line 235
;234:	case 2:
;235:		value = value > 99 ? 99 : value;
ADDRFP4 12
INDIRI4
CNSTI4 99
LEI4 $86
ADDRLP4 40
CNSTI4 99
ASGNI4
ADDRGP4 $87
JUMPV
LABELV $86
ADDRLP4 40
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $87
ADDRFP4 12
ADDRLP4 40
INDIRI4
ASGNI4
line 236
;236:		value = value < -9 ? -9 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -9
GEI4 $89
ADDRLP4 44
CNSTI4 -9
ASGNI4
ADDRGP4 $90
JUMPV
LABELV $89
ADDRLP4 44
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $90
ADDRFP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 237
;237:		break;
ADDRGP4 $76
JUMPV
LABELV $91
line 239
;238:	case 3:
;239:		value = value > 999 ? 999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 999
LEI4 $93
ADDRLP4 48
CNSTI4 999
ASGNI4
ADDRGP4 $94
JUMPV
LABELV $93
ADDRLP4 48
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $94
ADDRFP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 240
;240:		value = value < -99 ? -99 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -99
GEI4 $96
ADDRLP4 52
CNSTI4 -99
ASGNI4
ADDRGP4 $97
JUMPV
LABELV $96
ADDRLP4 52
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $97
ADDRFP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 241
;241:		break;
ADDRGP4 $76
JUMPV
LABELV $98
line 243
;242:	case 4:
;243:		value = value > 9999 ? 9999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9999
LEI4 $100
ADDRLP4 56
CNSTI4 9999
ASGNI4
ADDRGP4 $101
JUMPV
LABELV $100
ADDRLP4 56
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $101
ADDRFP4 12
ADDRLP4 56
INDIRI4
ASGNI4
line 244
;244:		value = value < -999 ? -999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -999
GEI4 $103
ADDRLP4 60
CNSTI4 -999
ASGNI4
ADDRGP4 $104
JUMPV
LABELV $103
ADDRLP4 60
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $104
ADDRFP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 245
;245:		break;
LABELV $75
LABELV $76
line 248
;246:	}
;247:
;248:	Com_sprintf (num, sizeof(num), "%i", value);
ADDRLP4 12
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $107
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 249
;249:	l = strlen(num);
ADDRLP4 12
ARGP4
ADDRLP4 32
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 250
;250:	if (l > width)
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
LEI4 $108
line 251
;251:		l = width;
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
LABELV $108
line 252
;252:	x += 2 + char_width*(width - l);
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRFP4 16
INDIRI4
ADDRFP4 8
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
MULI4
CNSTI4 2
ADDI4
ADDI4
ASGNI4
line 254
;253:
;254:	ptr = num;
ADDRLP4 0
ADDRLP4 12
ASGNP4
ADDRGP4 $111
JUMPV
LABELV $110
line 256
;255:	while (*ptr && l)
;256:	{
line 257
;257:		if (*ptr == '-')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $113
line 258
;258:			frame = STAT_MINUS;
ADDRLP4 8
CNSTI4 10
ASGNI4
ADDRGP4 $114
JUMPV
LABELV $113
line 260
;259:		else
;260:			frame = *ptr -'0';
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
LABELV $114
line 262
;261:
;262:		CG_DrawPic( x,y, char_width, char_height, cgs.media.numberShaders[frame] );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 20
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+304
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 263
;263:		x += char_width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRFP4 16
INDIRI4
ADDI4
ASGNI4
line 264
;264:		ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 265
;265:		l--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 266
;266:	}
LABELV $111
line 255
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
EQI4 $117
ADDRLP4 4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $110
LABELV $117
line 267
;267:}
LABELV $70
endproc CG_DrawField 64 20
export CG_Draw3DModel
proc CG_Draw3DModel 512 16
line 276
;268:#endif // MISSIONPACK
;269:
;270:/*
;271:================
;272:CG_Draw3DModel
;273:
;274:================
;275:*/
;276:void CG_Draw3DModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles ) {
line 280
;277:	refdef_t		refdef;
;278:	refEntity_t		ent;
;279:
;280:	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
ADDRLP4 508
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 508
INDIRI4
EQI4 $123
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 508
INDIRI4
NEI4 $119
LABELV $123
line 281
;281:		return;
ADDRGP4 $118
JUMPV
LABELV $119
line 284
;282:	}
;283:
;284:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 286
;285:
;286:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 288
;287:
;288:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 289
;289:	AnglesToAxis( angles, ent.axis );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 290
;290:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 291
;291:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 292
;292:	ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 293
;293:	ent.renderfx = RF_NOSHADOW;		// no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 295
;294:
;295:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 297
;296:
;297:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 299
;298:
;299:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 300
;300:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 302
;301:
;302:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 303
;303:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 304
;304:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 305
;305:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 307
;306:
;307:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 309
;308:
;309:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 310
;310:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 311
;311:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 312
;312:}
LABELV $118
endproc CG_Draw3DModel 512 16
export CG_DrawHead
proc CG_DrawHead 56 32
line 321
;313:
;314:/*
;315:================
;316:CG_DrawHead
;317:
;318:Used for both the status bar and the scoreboard
;319:================
;320:*/
;321:void CG_DrawHead( float x, float y, float w, float h, int clientNum, vec3_t headAngles ) {
line 328
;322:	clipHandle_t	cm;
;323:	clientInfo_t	*ci;
;324:	float			len;
;325:	vec3_t			origin;
;326:	vec3_t			mins, maxs;
;327:
;328:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
CNSTI4 1708
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 330
;329:
;330:	if ( cg_draw3dIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $140
line 331
;331:		cm = ci->headModel;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
line 332
;332:		if ( !cm ) {
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $143
line 333
;333:			return;
ADDRGP4 $138
JUMPV
LABELV $143
line 337
;334:		}
;335:
;336:		// offset the origin y and z to center the head
;337:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 339
;338:
;339:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 4+8
CNSTF4 3204448256
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 340
;340:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 4+4
CNSTF4 1056964608
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 344
;341:
;342:		// calculate distance so the head nearly fills the box
;343:		// assume heads are taller than wide
;344:		len = 0.7 * ( maxs[2] - mins[2] );		
ADDRLP4 44
CNSTF4 1060320051
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 345
;345:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 4
ADDRLP4 44
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 348
;346:
;347:		// allow per-model tweaking
;348:		VectorAdd( origin, ci->headOffset, origin );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRF4
ADDF4
ASGNF4
line 350
;349:
;350:		CG_Draw3DModel( x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 351
;351:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $141
JUMPV
LABELV $140
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $157
line 352
;352:		CG_DrawPic( x, y, w, h, ci->modelIcon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 353
;353:	}
LABELV $157
LABELV $141
line 356
;354:
;355:	// if they are deferred, draw a cross out
;356:	if ( ci->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
CNSTI4 0
EQI4 $160
line 357
;357:		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 cgs+152340+132
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 358
;358:	}
LABELV $160
line 359
;359:}
LABELV $138
endproc CG_DrawHead 56 32
export CG_DrawFlagModel
proc CG_DrawFlagModel 72 32
line 368
;360:
;361:/*
;362:================
;363:CG_DrawFlagModel
;364:
;365:Used for both the status bar and the scoreboard
;366:================
;367:*/
;368:void CG_DrawFlagModel( float x, float y, float w, float h, int team, qboolean force2D ) {
line 375
;369:	qhandle_t		cm;
;370:	float			len;
;371:	vec3_t			origin, angles;
;372:	vec3_t			mins, maxs;
;373:	qhandle_t		handle;
;374:
;375:	if ( !force2D && cg_draw3dIcons.integer ) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $165
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $165
line 377
;376:
;377:		VectorClear( angles );
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 64
INDIRF4
ASGNF4
line 379
;378:
;379:		cm = cgs.media.redFlagModel;
ADDRLP4 48
ADDRGP4 cgs+152340+36
INDIRI4
ASGNI4
line 382
;380:
;381:		// offset the origin y and z to center the flag
;382:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 384
;383:
;384:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 12+8
CNSTF4 3204448256
ADDRLP4 24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 385
;385:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 12+4
CNSTF4 1056964608
ADDRLP4 24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 389
;386:
;387:		// calculate distance so the flag nearly fills the box
;388:		// assume heads are taller than wide
;389:		len = 0.5 * ( maxs[2] - mins[2] );		
ADDRLP4 52
CNSTF4 1056964608
ADDRLP4 36+8
INDIRF4
ADDRLP4 24+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 390
;390:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 12
ADDRLP4 52
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 392
;391:
;392:		angles[YAW] = 60 * sin( cg.time / 2000.0 );;
ADDRGP4 cg+111708
INDIRI4
CVIF4 4
CNSTF4 1157234688
DIVF4
ARGF4
ADDRLP4 68
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+4
CNSTF4 1114636288
ADDRLP4 68
INDIRF4
MULF4
ASGNF4
line 394
;393:
;394:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $182
line 395
;395:			handle = cgs.media.redFlagModel;
ADDRLP4 56
ADDRGP4 cgs+152340+36
INDIRI4
ASGNI4
line 396
;396:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $183
JUMPV
LABELV $182
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $186
line 397
;397:			handle = cgs.media.blueFlagModel;
ADDRLP4 56
ADDRGP4 cgs+152340+40
INDIRI4
ASGNI4
line 398
;398:		} else if( team == TEAM_FREE ) {
ADDRGP4 $187
JUMPV
LABELV $186
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $164
line 399
;399:			handle = cgs.media.neutralFlagModel;
ADDRLP4 56
ADDRGP4 cgs+152340+44
INDIRI4
ASGNI4
line 400
;400:		} else {
line 401
;401:			return;
LABELV $191
LABELV $187
LABELV $183
line 403
;402:		}
;403:		CG_Draw3DModel( x, y, w, h, handle, 0, origin, angles );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 404
;404:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $166
JUMPV
LABELV $165
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $194
line 407
;405:		gitem_t *item;
;406:
;407:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $197
line 408
;408:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 409
;409:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $198
JUMPV
LABELV $197
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $199
line 410
;410:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 411
;411:		} else if( team == TEAM_FREE ) {
ADDRGP4 $200
JUMPV
LABELV $199
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $164
line 412
;412:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 413
;413:		} else {
line 414
;414:			return;
LABELV $202
LABELV $200
LABELV $198
line 416
;415:		}
;416:		if (item) {
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $203
line 417
;417:		  CG_DrawPic( x, y, w, h, cg_items[ ITEM_INDEX(item) ].icon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 418
;418:		}
LABELV $203
line 419
;419:	}
LABELV $194
LABELV $166
line 420
;420:}
LABELV $164
endproc CG_DrawFlagModel 72 32
proc CG_DrawStatusBarHead 56 24
line 430
;421:
;422:/*
;423:================
;424:CG_DrawStatusBarHead
;425:
;426:================
;427:*/
;428:#ifndef MISSIONPACK
;429:
;430:static void CG_DrawStatusBarHead( float x ) {
line 435
;431:	vec3_t		angles;
;432:	float		size, stretch;
;433:	float		frac;
;434:
;435:	VectorClear( angles );
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 4+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 437
;436:
;437:	if ( cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME ) {
ADDRGP4 cg+128804
INDIRF4
CNSTF4 0
EQF4 $209
ADDRGP4 cg+111708
INDIRI4
CVIF4 4
ADDRGP4 cg+128804
INDIRF4
SUBF4
CNSTF4 1140457472
GEF4 $209
line 438
;438:		frac = (float)(cg.time - cg.damageTime ) / DAMAGE_TIME;
ADDRLP4 0
ADDRGP4 cg+111708
INDIRI4
CVIF4 4
ADDRGP4 cg+128804
INDIRF4
SUBF4
CNSTF4 1140457472
DIVF4
ASGNF4
line 439
;439:		size = ICON_SIZE * 1.25 * ( 1.5 - frac * 0.5 );
ADDRLP4 16
CNSTF4 1114636288
CNSTF4 1069547520
CNSTF4 1056964608
ADDRLP4 0
INDIRF4
MULF4
SUBF4
MULF4
ASGNF4
line 441
;440:
;441:		stretch = size - ICON_SIZE * 1.25;
ADDRLP4 20
ADDRLP4 16
INDIRF4
CNSTF4 1114636288
SUBF4
ASGNF4
line 443
;442:		// kick in the direction of damage
;443:		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;
ADDRLP4 28
CNSTF4 1056964608
ASGNF4
ADDRLP4 32
ADDRLP4 20
INDIRF4
ASGNF4
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
ADDRGP4 cg+128808
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
MULF4
ADDF4
SUBF4
ASGNF4
line 445
;444:
;445:		cg.headStartYaw = 180 + cg.damageX * 45;
ADDRGP4 cg+128840
CNSTF4 1110704128
ADDRGP4 cg+128808
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 447
;446:
;447:		cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 36
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 40
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+128828
CNSTF4 1101004800
ADDRLP4 40
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 448
;448:		cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 44
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 48
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+128824
CNSTF4 1084227584
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 450
;449:
;450:		cg.headStartTime = cg.time;
ADDRGP4 cg+128844
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 451
;451:		cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+128832
ADDRGP4 cg+111708
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
CNSTF4 1157234688
ADDRLP4 52
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 452
;452:	} else {
ADDRGP4 $210
JUMPV
LABELV $209
line 453
;453:		if ( cg.time >= cg.headEndTime ) {
ADDRGP4 cg+111708
INDIRI4
ADDRGP4 cg+128832
INDIRI4
LTI4 $225
line 455
;454:			// select a new head angle
;455:			cg.headStartYaw = cg.headEndYaw;
ADDRGP4 cg+128840
ADDRGP4 cg+128828
INDIRF4
ASGNF4
line 456
;456:			cg.headStartPitch = cg.headEndPitch;
ADDRGP4 cg+128836
ADDRGP4 cg+128824
INDIRF4
ASGNF4
line 457
;457:			cg.headStartTime = cg.headEndTime;
ADDRGP4 cg+128844
ADDRGP4 cg+128832
INDIRI4
ASGNI4
line 458
;458:			cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+128832
ADDRGP4 cg+111708
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
CNSTF4 1157234688
ADDRLP4 28
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 460
;459:
;460:			cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+128828
CNSTF4 1101004800
ADDRLP4 36
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 461
;461:			cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 40
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 44
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+128824
CNSTF4 1084227584
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
line 462
;462:		}
LABELV $225
line 464
;463:
;464:		size = ICON_SIZE * 1.25;
ADDRLP4 16
CNSTF4 1114636288
ASGNF4
line 465
;465:	}
LABELV $210
line 468
;466:
;467:	// if the server was frozen for a while we may have a bad head start time
;468:	if ( cg.headStartTime > cg.time ) {
ADDRGP4 cg+128844
INDIRI4
ADDRGP4 cg+111708
INDIRI4
LEI4 $239
line 469
;469:		cg.headStartTime = cg.time;
ADDRGP4 cg+128844
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 470
;470:	}
LABELV $239
line 472
;471:
;472:	frac = ( cg.time - cg.headStartTime ) / (float)( cg.headEndTime - cg.headStartTime );
ADDRLP4 0
ADDRGP4 cg+111708
INDIRI4
ADDRGP4 cg+128844
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cg+128832
INDIRI4
ADDRGP4 cg+128844
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 473
;473:	frac = frac * frac * ( 3 - 2 * frac );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1077936128
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
MULF4
SUBF4
MULF4
ASGNF4
line 474
;474:	angles[YAW] = cg.headStartYaw + ( cg.headEndYaw - cg.headStartYaw ) * frac;
ADDRLP4 4+4
ADDRGP4 cg+128840
INDIRF4
ADDRGP4 cg+128828
INDIRF4
ADDRGP4 cg+128840
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 475
;475:	angles[PITCH] = cg.headStartPitch + ( cg.headEndPitch - cg.headStartPitch ) * frac;
ADDRLP4 4
ADDRGP4 cg+128836
INDIRF4
ADDRGP4 cg+128824
INDIRF4
ADDRGP4 cg+128836
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 477
;476:
;477:	CG_DrawHead( x, 480 - size, size, size, 
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1139802112
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 479
;478:				cg.snap->ps.clientNum, angles );
;479:}
LABELV $206
endproc CG_DrawStatusBarHead 56 24
proc CG_DrawStatusBarFlag 4 24
line 489
;480:#endif // MISSIONPACK
;481:
;482:/*
;483:================
;484:CG_DrawStatusBarFlag
;485:
;486:================
;487:*/
;488:#ifndef MISSIONPACK
;489:static void CG_DrawStatusBarFlag( float x, int team ) {
line 490
;490:	CG_DrawFlagModel( x, 480 - ICON_SIZE, ICON_SIZE, ICON_SIZE, team, qfalse );
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 0
CNSTF4 1111490560
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 491
;491:}
LABELV $257
endproc CG_DrawStatusBarFlag 4 24
export CG_DrawTeamBackground
proc CG_DrawTeamBackground 16 20
line 501
;492:#endif // MISSIONPACK
;493:
;494:/*
;495:================
;496:CG_DrawTeamBackground
;497:
;498:================
;499:*/
;500:void CG_DrawTeamBackground( int x, int y, int w, int h, float alpha, int team )
;501:{
line 504
;502:	vec4_t		hcolor;
;503:
;504:	hcolor[3] = alpha;
ADDRLP4 0+12
ADDRFP4 16
INDIRF4
ASGNF4
line 505
;505:	if ( team == TEAM_RED ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
NEI4 $260
line 506
;506:		hcolor[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 507
;507:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 508
;508:		hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 509
;509:	} else if ( team == TEAM_BLUE ) {
ADDRGP4 $261
JUMPV
LABELV $260
ADDRFP4 20
INDIRI4
CNSTI4 2
NEI4 $258
line 510
;510:		hcolor[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 511
;511:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 512
;512:		hcolor[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 513
;513:	} else {
line 514
;514:		return;
LABELV $265
LABELV $261
line 516
;515:	}
;516:	trap_R_SetColor( hcolor );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 517
;517:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+152340+128
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 518
;518:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 519
;519:}
LABELV $258
endproc CG_DrawTeamBackground 16 20
data
align 4
LABELV $271
byte 4 1065353216
byte 4 1060152279
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
byte 4 1056964608
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
code
proc CG_DrawStatusBar 128 32
line 528
;520:
;521:/*
;522:================
;523:CG_DrawStatusBar
;524:
;525:================
;526:*/
;527:#ifndef MISSIONPACK
;528:static void CG_DrawStatusBar( void ) {
line 551
;529:	int			color;
;530:	centity_t	*cent;
;531:	playerState_t	*ps;
;532:	int			value;
;533:	vec4_t		hcolor;
;534:	vec3_t		angles;
;535:	vec3_t		origin;
;536:	char		*s;
;537:	int			w;
;538:	int			current, limit;
;539:	vec4_t		wlcolor;
;540:	int			wlx;
;541:#ifdef MISSIONPACK
;542:	qhandle_t	handle;
;543:#endif
;544:	static float colors[4][4] = { 
;545://		{ 0.2, 1.0, 0.2, 1.0 } , { 1.0, 0.2, 0.2, 1.0 }, {0.5, 0.5, 0.5, 1} };
;546:		{ 1.0f, 0.69f, 0.0f, 1.0f },    // normal
;547:		{ 1.0f, 0.2f, 0.2f, 1.0f },     // low health
;548:		{ 0.5f, 0.5f, 0.5f, 1.0f },     // weapon firing
;549:		{ 1.0f, 1.0f, 1.0f, 1.0f } };   // health > 100
;550:
;551:	if ( cg_drawStatus.integer == 0 ) {
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
NEI4 $272
line 552
;552:		return;
ADDRGP4 $270
JUMPV
LABELV $272
line 556
;553:	}
;554:
;555:	// draw the team background
;556:	CG_DrawTeamBackground( 0, 420, 640, 60, 0.33f, cg.snap->ps.persistant[PERS_TEAM] );
CNSTI4 0
ARGI4
CNSTI4 420
ARGI4
CNSTI4 640
ARGI4
CNSTI4 60
ARGI4
CNSTF4 1051260355
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
line 558
;557:
;558:	cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 8
CNSTI4 740
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 559
;559:	ps = &cg.snap->ps;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 561
;560:
;561:	VectorClear( angles );
ADDRLP4 92
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 92
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 92
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 92
INDIRF4
ASGNF4
line 564
;562:
;563:	// draw any 3D icons first, so the changes back to 2D are minimized
;564:	if ( cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel ) {
ADDRLP4 96
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRLP4 96
INDIRI4
ADDRLP4 100
INDIRI4
EQI4 $280
CNSTI4 144
ADDRLP4 96
INDIRI4
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ADDRLP4 100
INDIRI4
EQI4 $280
line 565
;565:		origin[0] = 70;
ADDRLP4 48
CNSTF4 1116471296
ASGNF4
line 566
;566:		origin[1] = 0;
ADDRLP4 48+4
CNSTF4 0
ASGNF4
line 567
;567:		origin[2] = 0;
ADDRLP4 48+8
CNSTF4 0
ASGNF4
line 568
;568:		angles[YAW] = 90 + 20 * sin( cg.time / 1000.0 );
ADDRGP4 cg+111708
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRLP4 104
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 12+4
CNSTF4 1101004800
ADDRLP4 104
INDIRF4
MULF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 569
;569:		CG_Draw3DModel( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 108
CNSTF4 1111490560
ASGNF4
ADDRLP4 108
INDIRF4
ARGF4
ADDRLP4 108
INDIRF4
ARGF4
CNSTI4 144
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 571
;570:					   cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles );
;571:	}
LABELV $280
line 573
;572:
;573:	CG_DrawStatusBarHead( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE );
CNSTF4 1133412352
ARGF4
ADDRGP4 CG_DrawStatusBarHead
CALLV
pop
line 575
;574:
;575:	if( cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
ADDRGP4 cg+111740+312+28
INDIRI4
CNSTI4 0
EQI4 $288
line 576
;576:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_RED );
CNSTF4 1134985216
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 577
;577:	} else if( cg.predictedPlayerState.powerups[PW_BLUEFLAG] ) {
ADDRGP4 $289
JUMPV
LABELV $288
ADDRGP4 cg+111740+312+32
INDIRI4
CNSTI4 0
EQI4 $293
line 578
;578:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_BLUE );
CNSTF4 1134985216
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 579
;579:	} else if( cg.predictedPlayerState.powerups[PW_NEUTRALFLAG] ) {
ADDRGP4 $294
JUMPV
LABELV $293
ADDRGP4 cg+111740+312+36
INDIRI4
CNSTI4 0
EQI4 $298
line 580
;580:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_FREE );
CNSTF4 1134985216
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 581
;581:	}
LABELV $298
LABELV $294
LABELV $289
line 583
;582:
;583:	if ( ps->stats[ STAT_ARMOR ] ) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
EQI4 $303
line 584
;584:		origin[0] = 90;
ADDRLP4 48
CNSTF4 1119092736
ASGNF4
line 585
;585:		origin[1] = 0;
ADDRLP4 48+4
CNSTF4 0
ASGNF4
line 586
;586:		origin[2] = -10;
ADDRLP4 48+8
CNSTF4 3240099840
ASGNF4
line 587
;587:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRLP4 12+4
CNSTI4 360
ADDRGP4 cg+111708
INDIRI4
CNSTI4 2047
BANDI4
MULI4
CVIF4 4
CNSTF4 1157627904
DIVF4
ASGNF4
line 588
;588:		CG_Draw3DModel( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
CNSTF4 1139474432
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 104
CNSTF4 1111490560
ASGNF4
ADDRLP4 104
INDIRF4
ARGF4
ADDRLP4 104
INDIRF4
ARGF4
ADDRGP4 cgs+152340+120
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 590
;589:					   cgs.media.armorModel, 0, origin, angles );
;590:	}
LABELV $303
line 608
;591:#ifdef MISSIONPACK
;592:	if( cgs.gametype == GT_HARVESTER ) {
;593:		origin[0] = 90;
;594:		origin[1] = 0;
;595:		origin[2] = -10;
;596:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
;597:		if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;598:			handle = cgs.media.redCubeModel;
;599:		} else {
;600:			handle = cgs.media.blueCubeModel;
;601:		}
;602:		CG_Draw3DModel( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 416, ICON_SIZE, ICON_SIZE, handle, 0, origin, angles );
;603:	}
;604:#endif
;605:	//
;606:	// ammo
;607:	//
;608:	if ( cent->currentState.weapon ) {
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $311
line 609
;609:		value = ps->ammo[cent->currentState.weapon];
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ASGNI4
line 610
;610:		if ( value > -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
LEI4 $313
line 611
;611:			if ( cg.predictedPlayerState.weaponstate == WEAPON_FIRING
ADDRGP4 cg+111740+148
INDIRI4
CNSTI4 3
NEI4 $315
ADDRGP4 cg+111740+44
INDIRI4
CNSTI4 100
LEI4 $315
line 612
;612:				&& cg.predictedPlayerState.weaponTime > 100 ) {
line 614
;613:				// draw as dark grey when reloading
;614:				color = 2;	// dark grey
ADDRLP4 88
CNSTI4 2
ASGNI4
line 615
;615:			} else {
ADDRGP4 $316
JUMPV
LABELV $315
line 616
;616:				if ( value >= 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $321
line 617
;617:					color = 0;	// green
ADDRLP4 88
CNSTI4 0
ASGNI4
line 618
;618:				} else {
ADDRGP4 $322
JUMPV
LABELV $321
line 619
;619:					color = 1;	// red
ADDRLP4 88
CNSTI4 1
ASGNI4
line 620
;620:				}
LABELV $322
line 621
;621:			}
LABELV $316
line 622
;622:			trap_R_SetColor( colors[color] );
ADDRLP4 88
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $271
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 624
;623:			
;624:			CG_DrawField (0, 432, 3, value, 32, 48);
CNSTI4 0
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 625
;625:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 628
;626:
;627:			// if we didn't draw a 3D icon, draw a 2D icon for ammo
;628:			if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
ADDRLP4 104
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 104
INDIRI4
NEI4 $323
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 104
INDIRI4
EQI4 $323
line 631
;629:				qhandle_t	icon;
;630:
;631:				icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
ADDRLP4 108
CNSTI4 144
ADDRGP4 cg+111740+144
INDIRI4
MULI4
ADDRGP4 cg_weapons+72
ADDP4
INDIRI4
ASGNI4
line 632
;632:				if ( icon ) {
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $330
line 633
;633:					CG_DrawPic( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, icon );
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 112
CNSTF4 1111490560
ASGNF4
ADDRLP4 112
INDIRF4
ARGF4
ADDRLP4 112
INDIRF4
ARGF4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 634
;634:				}
LABELV $330
line 635
;635:			}
LABELV $323
line 636
;636:		}
LABELV $313
line 637
;637:	}
LABELV $311
line 642
;638:
;639:	//
;640:	// health
;641:	//
;642:	value = ps->stats[STAT_HEALTH];
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 643
;643:	if ( value > 100 ) {
ADDRLP4 0
INDIRI4
CNSTI4 100
LEI4 $332
line 644
;644:		trap_R_SetColor( colors[3] );		// white
ADDRGP4 $271+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 645
;645:	} else if (value > 25) {
ADDRGP4 $333
JUMPV
LABELV $332
ADDRLP4 0
INDIRI4
CNSTI4 25
LEI4 $335
line 646
;646:		trap_R_SetColor( colors[0] );	// green
ADDRGP4 $271
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 647
;647:	} else if (value > 0) {
ADDRGP4 $336
JUMPV
LABELV $335
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $337
line 648
;648:		color = (cg.time >> 8) & 1;	// flash
ADDRLP4 88
ADDRGP4 cg+111708
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 649
;649:		trap_R_SetColor( colors[color] );
ADDRLP4 88
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $271
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 650
;650:	} else {
ADDRGP4 $338
JUMPV
LABELV $337
line 651
;651:		trap_R_SetColor( colors[1] );	// red
ADDRGP4 $271+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 652
;652:	}
LABELV $338
LABELV $336
LABELV $333
line 655
;653:
;654:	// stretch the health up when taking damage
;655:	CG_DrawField ( 185, 432, 3, value, 32, 48);
CNSTI4 185
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 656
;656:	CG_ColorForHealth( hcolor );
ADDRLP4 64
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 657
;657:	trap_R_SetColor( hcolor );
ADDRLP4 64
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 661
;658:
;659:	// EMERALD
;660:	// weapon limits
;661:	current = ps->stats[STAT_WEAPONCOUNT] + 2;
ADDRLP4 40
ADDRLP4 4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 662
;662:	limit = ps->stats[STAT_MAXWEAPONS] + 3;
ADDRLP4 44
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 663
;663:	s = va("%i/%i", current, limit);
ADDRGP4 $341
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 104
INDIRP4
ASGNP4
line 664
;664:	w = CG_DrawStrlen(s) * BIGCHAR_WIDTH;
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 84
ADDRLP4 108
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 667
;665:
;666:	// CG_DrawBigString(370, 400, s, 1.0F);
;667:	if (current >= limit) {
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LTI4 $342
line 668
;668:		Vector4Copy(colors[1], wlcolor);
ADDRLP4 24
ADDRGP4 $271+16
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRGP4 $271+16+4
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRGP4 $271+16+8
INDIRF4
ASGNF4
ADDRLP4 24+12
ADDRGP4 $271+16+12
INDIRF4
ASGNF4
line 669
;669:	}
ADDRGP4 $343
JUMPV
LABELV $342
line 670
;670:	else {
line 671
;671:		Vector4Copy(colors[3], wlcolor);
ADDRLP4 24
ADDRGP4 $271+48
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRGP4 $271+48+4
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRGP4 $271+48+8
INDIRF4
ASGNF4
ADDRLP4 24+12
ADDRGP4 $271+48+12
INDIRF4
ASGNF4
line 672
;672:	}
LABELV $343
line 674
;673:
;674:	if (current >= 10 && limit >= 10) {
ADDRLP4 112
CNSTI4 10
ASGNI4
ADDRLP4 40
INDIRI4
ADDRLP4 112
INDIRI4
LTI4 $364
ADDRLP4 44
INDIRI4
ADDRLP4 112
INDIRI4
LTI4 $364
line 675
;675:		wlx = 28;
ADDRLP4 80
CNSTI4 28
ASGNI4
line 676
;676:	}
ADDRGP4 $365
JUMPV
LABELV $364
line 677
;677:	else if (current >= 10 || limit >= 10) {
ADDRLP4 116
CNSTI4 10
ASGNI4
ADDRLP4 40
INDIRI4
ADDRLP4 116
INDIRI4
GEI4 $368
ADDRLP4 44
INDIRI4
ADDRLP4 116
INDIRI4
LTI4 $366
LABELV $368
line 678
;678:		wlx = 15;
ADDRLP4 80
CNSTI4 15
ASGNI4
line 679
;679:	}
ADDRGP4 $367
JUMPV
LABELV $366
line 680
;680:	else {
line 681
;681:		wlx = 0;
ADDRLP4 80
CNSTI4 0
ASGNI4
line 682
;682:	}
LABELV $367
LABELV $365
line 683
;683:	CG_DrawBigStringColor(585 - wlx, 380, s, wlcolor);
CNSTI4 585
ADDRLP4 80
INDIRI4
SUBI4
ARGI4
CNSTI4 380
ARGI4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 CG_DrawBigStringColor
CALLV
pop
line 689
;684:	// CG_DrawPic(370, 400, 24, 36, cgs.media.numberShaders[4]);
;685:
;686:	//
;687:	// armor
;688:	//
;689:	value = ps->stats[STAT_ARMOR];
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 690
;690:	if (value > 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $369
line 691
;691:		trap_R_SetColor( colors[0] );
ADDRGP4 $271
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 692
;692:		CG_DrawField (370, 432, 3, value, 32, 48);
CNSTI4 370
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 693
;693:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 695
;694:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;695:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
ADDRLP4 120
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 120
INDIRI4
NEI4 $371
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 120
INDIRI4
EQI4 $371
line 696
;696:			CG_DrawPic( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, cgs.media.armorIcon );
CNSTF4 1139474432
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 124
CNSTF4 1111490560
ASGNF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRGP4 cgs+152340+124
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 697
;697:		}
LABELV $371
line 699
;698:
;699:	}
LABELV $369
line 723
;700:#ifdef MISSIONPACK
;701:	//
;702:	// cubes
;703:	//
;704:	if( cgs.gametype == GT_HARVESTER ) {
;705:		value = ps->generic1;
;706:		if( value > 99 ) {
;707:			value = 99;
;708:		}
;709:		trap_R_SetColor( colors[0] );
;710:		CG_DrawField (640 - (CHAR_WIDTH*2 + TEXT_ICON_SPACE + ICON_SIZE), 432, 2, value);
;711:		trap_R_SetColor( NULL );
;712:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;713:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
;714:			if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;715:				handle = cgs.media.redCubeIcon;
;716:			} else {
;717:				handle = cgs.media.blueCubeIcon;
;718:			}
;719:			CG_DrawPic( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 432, ICON_SIZE, ICON_SIZE, handle );
;720:		}
;721:	}
;722:#endif
;723:}
LABELV $270
endproc CG_DrawStatusBar 128 32
proc CG_DrawAttacker 52 24
line 740
;724:#endif
;725:
;726:/*
;727:===========================================================================================
;728:
;729:  UPPER RIGHT CORNER
;730:
;731:===========================================================================================
;732:*/
;733:
;734:/*
;735:================
;736:CG_DrawAttacker
;737:
;738:================
;739:*/
;740:static float CG_DrawAttacker( float y ) {
line 748
;741:	int			t;
;742:	float		size;
;743:	vec3_t		angles;
;744:	const char	*info;
;745:	const char	*name;
;746:	int			clientNum;
;747:
;748:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+111740+184
INDIRI4
CNSTI4 0
GTI4 $378
line 749
;749:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $377
JUMPV
LABELV $378
line 752
;750:	}
;751:
;752:	if ( !cg.attackerTime ) {
ADDRGP4 cg+128532
INDIRI4
CNSTI4 0
NEI4 $382
line 753
;753:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $377
JUMPV
LABELV $382
line 756
;754:	}
;755:
;756:	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
ADDRLP4 0
ADDRGP4 cg+111740+248+24
INDIRI4
ASGNI4
line 757
;757:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $392
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $392
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $388
LABELV $392
line 758
;758:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $377
JUMPV
LABELV $388
line 761
;759:	}
;760:
;761:	t = cg.time - cg.attackerTime;
ADDRLP4 24
ADDRGP4 cg+111708
INDIRI4
ADDRGP4 cg+128532
INDIRI4
SUBI4
ASGNI4
line 762
;762:	if ( t > ATTACKER_HEAD_TIME ) {
ADDRLP4 24
INDIRI4
CNSTI4 10000
LEI4 $395
line 763
;763:		cg.attackerTime = 0;
ADDRGP4 cg+128532
CNSTI4 0
ASGNI4
line 764
;764:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $377
JUMPV
LABELV $395
line 767
;765:	}
;766:
;767:	size = ICON_SIZE * 1.25;
ADDRLP4 4
CNSTF4 1114636288
ASGNF4
line 769
;768:
;769:	angles[PITCH] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 770
;770:	angles[YAW] = 180;
ADDRLP4 8+4
CNSTF4 1127481344
ASGNF4
line 771
;771:	angles[ROLL] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 772
;772:	CG_DrawHead( 640 - size, y, size, size, clientNum, angles );
CNSTF4 1142947840
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 774
;773:
;774:	info = CG_ConfigString( CS_PLAYERS + clientNum );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 40
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 40
INDIRP4
ASGNP4
line 775
;775:	name = Info_ValueForKey(  info, "n" );
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $400
ARGP4
ADDRLP4 44
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 44
INDIRP4
ASGNP4
line 776
;776:	y += size;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 777
;777:	CG_DrawBigString( 640 - ( Q_PrintStrlen( name ) * BIGCHAR_WIDTH), y, name, 0.5 );
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Q_PrintStrlen
CALLI4
ASGNI4
CNSTI4 640
ADDRLP4 48
INDIRI4
CNSTI4 4
LSHI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1056964608
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 779
;778:
;779:	return y + BIGCHAR_HEIGHT + 2;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1073741824
ADDF4
RETF4
LABELV $377
endproc CG_DrawAttacker 52 24
proc CG_DrawSnapshot 16 16
line 787
;780:}
;781:
;782:/*
;783:==================
;784:CG_DrawSnapshot
;785:==================
;786:*/
;787:static float CG_DrawSnapshot( float y ) {
line 791
;788:	char		*s;
;789:	int			w;
;790:
;791:	s = va( "time:%i snap:%i cmd:%i", cg.snap->serverTime, 
ADDRGP4 $402
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+28
INDIRI4
ARGI4
ADDRGP4 cgs+31444
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
line 793
;792:		cg.latestSnapshotNum, cgs.serverCommandSequence );
;793:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 795
;794:
;795:	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 797
;796:
;797:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $401
endproc CG_DrawSnapshot 16 16
bss
align 4
LABELV $407
skip 16
align 4
LABELV $408
skip 4
align 4
LABELV $409
skip 4
code
proc CG_DrawFPS 44 16
line 806
;798:}
;799:
;800:/*
;801:==================
;802:CG_DrawFPS
;803:==================
;804:*/
;805:#define	FPS_FRAMES	4
;806:static float CG_DrawFPS( float y ) {
line 818
;807:	char		*s;
;808:	int			w;
;809:	static int	previousTimes[FPS_FRAMES];
;810:	static int	index;
;811:	int		i, total;
;812:	int		fps;
;813:	static	int	previous;
;814:	int		t, frameTime;
;815:
;816:	// don't use serverTime, because that will be drifting to
;817:	// correct for internet lag changes, timescales, timedemos, etc
;818:	t = trap_Milliseconds();
ADDRLP4 28
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ASGNI4
line 819
;819:	frameTime = t - previous;
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRGP4 $409
INDIRI4
SUBI4
ASGNI4
line 820
;820:	previous = t;
ADDRGP4 $409
ADDRLP4 8
INDIRI4
ASGNI4
line 822
;821:
;822:	previousTimes[index % FPS_FRAMES] = frameTime;
ADDRGP4 $408
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $407
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 823
;823:	index++;
ADDRLP4 32
ADDRGP4 $408
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 824
;824:	if ( index > FPS_FRAMES ) {
ADDRGP4 $408
INDIRI4
CNSTI4 4
LEI4 $410
line 826
;825:		// average multiple frames together to smooth changes out a bit
;826:		total = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 827
;827:		for ( i = 0 ; i < FPS_FRAMES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $412
line 828
;828:			total += previousTimes[i];
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $407
ADDP4
INDIRI4
ADDI4
ASGNI4
line 829
;829:		}
LABELV $413
line 827
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $412
line 830
;830:		if ( !total ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $416
line 831
;831:			total = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 832
;832:		}
LABELV $416
line 833
;833:		fps = 1000 * FPS_FRAMES / total;
ADDRLP4 24
CNSTI4 4000
ADDRLP4 4
INDIRI4
DIVI4
ASGNI4
line 835
;834:
;835:		s = va( "%ifps", fps );
ADDRGP4 $418
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 836
;836:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 838
;837:
;838:		CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 20
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 839
;839:	}
LABELV $410
line 841
;840:
;841:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $406
endproc CG_DrawFPS 44 16
proc CG_DrawTimer 32 16
line 849
;842:}
;843:
;844:/*
;845:=================
;846:CG_DrawTimer
;847:=================
;848:*/
;849:static float CG_DrawTimer( float y ) {
line 855
;850:	char		*s;
;851:	int			w;
;852:	int			mins, seconds, tens;
;853:	int			msec;
;854:
;855:	msec = cg.time - cgs.levelStartTime;
ADDRLP4 20
ADDRGP4 cg+111708
INDIRI4
ADDRGP4 cgs+34796
INDIRI4
SUBI4
ASGNI4
line 857
;856:
;857:	seconds = msec / 1000;
ADDRLP4 0
ADDRLP4 20
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 858
;858:	mins = seconds / 60;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 859
;859:	seconds -= mins * 60;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDRLP4 8
INDIRI4
MULI4
SUBI4
ASGNI4
line 860
;860:	tens = seconds / 10;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 861
;861:	seconds -= tens * 10;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 10
ADDRLP4 12
INDIRI4
MULI4
SUBI4
ASGNI4
line 863
;862:
;863:	s = va( "%i:%i%i", mins, tens, seconds );
ADDRGP4 $422
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 864
;864:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 28
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 866
;865:
;866:	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 868
;867:
;868:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $419
endproc CG_DrawTimer 32 16
proc CG_DrawTeamOverlay 148 36
line 878
;869:}
;870:
;871:
;872:/*
;873:=================
;874:CG_DrawTeamOverlay
;875:=================
;876:*/
;877:
;878:static float CG_DrawTeamOverlay( float y, qboolean right, qboolean upper ) {
line 890
;879:	int x, w, h, xx;
;880:	int i, j, len;
;881:	const char *p;
;882:	vec4_t		hcolor;
;883:	int pwidth, lwidth;
;884:	int plyrs;
;885:	char st[16];
;886:	clientInfo_t *ci;
;887:	gitem_t	*item;
;888:	int ret_y, count;
;889:
;890:	if ( !cg_drawTeamOverlay.integer ) {
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 0
NEI4 $424
line 891
;891:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $423
JUMPV
LABELV $424
line 894
;892:	}
;893:
;894:	if ( cg.snap->ps.persistant[PERS_TEAM] != TEAM_RED && cg.snap->ps.persistant[PERS_TEAM] != TEAM_BLUE ) {
ADDRLP4 92
CNSTI4 304
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $427
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $427
line 895
;895:		return y; // Not on any team
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $423
JUMPV
LABELV $427
line 898
;896:	}
;897:
;898:	plyrs = 0;
ADDRLP4 76
CNSTI4 0
ASGNI4
line 901
;899:
;900:	// max player name width
;901:	pwidth = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 902
;902:	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
ADDRGP4 numSortedTeamPlayers
INDIRI4
CNSTI4 8
LEI4 $432
ADDRLP4 96
CNSTI4 8
ASGNI4
ADDRGP4 $433
JUMPV
LABELV $432
ADDRLP4 96
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
LABELV $433
ADDRLP4 48
ADDRLP4 96
INDIRI4
ASGNI4
line 903
;903:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $437
JUMPV
LABELV $434
line 904
;904:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 1708
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 905
;905:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $439
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $439
line 906
;906:			plyrs++;
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 907
;907:			len = CG_DrawStrlen(ci->name);
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 104
INDIRI4
ASGNI4
line 908
;908:			if (len > pwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 56
INDIRI4
LEI4 $442
line 909
;909:				pwidth = len;
ADDRLP4 56
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $442
line 910
;910:		}
LABELV $439
line 911
;911:	}
LABELV $435
line 903
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $437
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $434
line 913
;912:
;913:	if (!plyrs)
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $444
line 914
;914:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $423
JUMPV
LABELV $444
line 916
;915:
;916:	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
ADDRLP4 56
INDIRI4
CNSTI4 12
LEI4 $446
line 917
;917:		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;
ADDRLP4 56
CNSTI4 12
ASGNI4
LABELV $446
line 920
;918:
;919:	// max location name width
;920:	lwidth = 0;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 921
;921:	for (i = 1; i < MAX_LOCATIONS; i++) {
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $448
line 922
;922:		p = CG_ConfigString(CS_LOCATIONS + i);
ADDRLP4 8
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 100
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 100
INDIRP4
ASGNP4
line 923
;923:		if (p && *p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $452
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $452
line 924
;924:			len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 108
INDIRI4
ASGNI4
line 925
;925:			if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $454
line 926
;926:				lwidth = len;
ADDRLP4 44
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $454
line 927
;927:		}
LABELV $452
line 928
;928:	}
LABELV $449
line 921
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $448
line 930
;929:
;930:	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
ADDRLP4 44
INDIRI4
CNSTI4 16
LEI4 $456
line 931
;931:		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;
ADDRLP4 44
CNSTI4 16
ASGNI4
LABELV $456
line 933
;932:
;933:	w = (pwidth + lwidth + 4 + 7) * TINYCHAR_WIDTH;
ADDRLP4 80
ADDRLP4 56
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
CNSTI4 3
LSHI4
CNSTI4 32
ADDI4
CNSTI4 56
ADDI4
ASGNI4
line 935
;934:
;935:	if ( right )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $458
line 936
;936:		x = 640 - w;
ADDRLP4 52
CNSTI4 640
ADDRLP4 80
INDIRI4
SUBI4
ASGNI4
ADDRGP4 $459
JUMPV
LABELV $458
line 938
;937:	else
;938:		x = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
LABELV $459
line 940
;939:
;940:	h = plyrs * TINYCHAR_HEIGHT;
ADDRLP4 84
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 942
;941:
;942:	if ( upper ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $460
line 943
;943:		ret_y = y + h;
ADDRLP4 88
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
ADDF4
CVFI4 4
ASGNI4
line 944
;944:	} else {
ADDRGP4 $461
JUMPV
LABELV $460
line 945
;945:		y -= h;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 946
;946:		ret_y = y;
ADDRLP4 88
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 947
;947:	}
LABELV $461
line 949
;948:
;949:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $462
line 950
;950:		hcolor[0] = 1.0f;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 951
;951:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 952
;952:		hcolor[2] = 0.0f;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 953
;953:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 954
;954:	} else { // if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 $463
JUMPV
LABELV $462
line 955
;955:		hcolor[0] = 0.0f;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 956
;956:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 957
;957:		hcolor[2] = 1.0f;
ADDRLP4 24+8
CNSTF4 1065353216
ASGNF4
line 958
;958:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 959
;959:	}
LABELV $463
line 960
;960:	trap_R_SetColor( hcolor );
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 961
;961:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRLP4 52
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 84
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+152340+128
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 962
;962:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 964
;963:
;964:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $476
JUMPV
LABELV $473
line 965
;965:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 1708
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 966
;966:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $478
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $478
line 968
;967:
;968:			hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;
ADDRLP4 104
CNSTF4 1065353216
ASGNF4
ADDRLP4 24+12
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 104
INDIRF4
ASGNF4
line 970
;969:
;970:			xx = x + TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 972
;971:
;972:			CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 112
CNSTI4 8
ASGNI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ARGI4
CNSTI4 12
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 976
;973:				ci->name, hcolor, qfalse, qfalse,
;974:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXNAME_WIDTH);
;975:
;976:			if (lwidth) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $484
line 977
;977:				p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 116
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 116
INDIRP4
ASGNP4
line 978
;978:				if (!p || !*p)
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $488
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $486
LABELV $488
line 979
;979:					p = "unknown";
ADDRLP4 20
ADDRGP4 $489
ASGNP4
LABELV $486
line 980
;980:				len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 124
INDIRI4
ASGNI4
line 981
;981:				if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $490
line 982
;982:					len = lwidth;
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
LABELV $490
line 986
;983:
;984://				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth + 
;985://					((lwidth/2 - len/2) * TINYCHAR_WIDTH);
;986:				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 16
ADDI4
ADDRLP4 56
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 987
;987:				CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 990
;988:					p, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
;989:					TEAM_OVERLAY_MAXLOCATION_WIDTH);
;990:			}
LABELV $484
line 992
;991:
;992:			CG_GetColorForHealth( ci->health, ci->armor, hcolor );
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 994
;993:
;994:			Com_sprintf (st, sizeof(st), "%3i %3i", ci->health,	ci->armor);
ADDRLP4 60
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $492
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 996
;995:
;996:			xx = x + TINYCHAR_WIDTH * 3 + 
ADDRLP4 124
CNSTI4 3
ASGNI4
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 24
ADDI4
ADDRLP4 56
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ADDRLP4 44
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ASGNI4
line 999
;997:				TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;
;998:
;999:			CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1004
;1000:				st, hcolor, qfalse, qfalse,
;1001:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0 );
;1002:
;1003:			// draw weapon icon
;1004:			xx += TINYCHAR_WIDTH * 3;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 1006
;1005:
;1006:			if ( cg_weapons[ci->curWeapon].weaponIcon ) {
CNSTI4 144
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $493
line 1007
;1007:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 136
CNSTF4 1090519040
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
CNSTI4 144
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1009
;1008:					cg_weapons[ci->curWeapon].weaponIcon );
;1009:			} else {
ADDRGP4 $494
JUMPV
LABELV $493
line 1010
;1010:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 136
CNSTF4 1090519040
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRGP4 cgs+152340+132
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1012
;1011:					cgs.media.deferShader );
;1012:			}
LABELV $494
line 1015
;1013:
;1014:			// Draw powerup icons
;1015:			if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $499
line 1016
;1016:				xx = x;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 1017
;1017:			} else {
ADDRGP4 $500
JUMPV
LABELV $499
line 1018
;1018:				xx = x + w - TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
CNSTI4 8
SUBI4
ASGNI4
line 1019
;1019:			}
LABELV $500
line 1020
;1020:			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $501
line 1021
;1021:				if (ci->powerups & (1 << j)) {
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $505
line 1023
;1022:
;1023:					item = BG_FindItemForPowerup( j );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 136
INDIRP4
ASGNP4
line 1025
;1024:
;1025:					if (item) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $507
line 1026
;1026:						CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 144
CNSTF4 1090519040
ASGNF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1028
;1027:						trap_R_RegisterShader( item->icon ) );
;1028:						if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $509
line 1029
;1029:							xx -= TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 1030
;1030:						} else {
ADDRGP4 $510
JUMPV
LABELV $509
line 1031
;1031:							xx += TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 1032
;1032:						}
LABELV $510
line 1033
;1033:					}
LABELV $507
line 1034
;1034:				}
LABELV $505
line 1035
;1035:			}
LABELV $502
line 1020
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 14
LEI4 $501
line 1037
;1036:
;1037:			y += TINYCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1038
;1038:		}
LABELV $478
line 1039
;1039:	}
LABELV $474
line 964
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $476
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $473
line 1041
;1040:
;1041:	return ret_y;
ADDRLP4 88
INDIRI4
CVIF4 4
RETF4
LABELV $423
endproc CG_DrawTeamOverlay 148 36
proc CG_DrawUpperRight 12 12
line 1052
;1042://#endif
;1043:}
;1044:
;1045:
;1046:/*
;1047:=====================
;1048:CG_DrawUpperRight
;1049:
;1050:=====================
;1051:*/
;1052:static void CG_DrawUpperRight( void ) {
line 1055
;1053:	float	y;
;1054:
;1055:	y = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1057
;1056:
;1057:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 1 ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $512
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 1
NEI4 $512
line 1058
;1058:		y = CG_DrawTeamOverlay( y, qtrue, qtrue );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1059
;1059:	} 
LABELV $512
line 1060
;1060:	if ( cg_drawSnapshot.integer ) {
ADDRGP4 cg_drawSnapshot+12
INDIRI4
CNSTI4 0
EQI4 $516
line 1061
;1061:		y = CG_DrawSnapshot( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawSnapshot
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1062
;1062:	}
LABELV $516
line 1063
;1063:	if ( cg_drawFPS.integer ) {
ADDRGP4 cg_drawFPS+12
INDIRI4
CNSTI4 0
EQI4 $519
line 1064
;1064:		y = CG_DrawFPS( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawFPS
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1065
;1065:	}
LABELV $519
line 1066
;1066:	if ( cg_drawTimer.integer ) {
ADDRGP4 cg_drawTimer+12
INDIRI4
CNSTI4 0
EQI4 $522
line 1067
;1067:		y = CG_DrawTimer( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawTimer
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1068
;1068:	}
LABELV $522
line 1069
;1069:	if ( cg_drawAttacker.integer ) {
ADDRGP4 cg_drawAttacker+12
INDIRI4
CNSTI4 0
EQI4 $525
line 1070
;1070:		y = CG_DrawAttacker( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawAttacker
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1071
;1071:	}
LABELV $525
line 1073
;1072:
;1073:}
LABELV $511
endproc CG_DrawUpperRight 12 12
proc CG_DrawScores 76 20
line 1091
;1074:
;1075:/*
;1076:===========================================================================================
;1077:
;1078:  LOWER RIGHT CORNER
;1079:
;1080:===========================================================================================
;1081:*/
;1082:
;1083:/*
;1084:=================
;1085:CG_DrawScores
;1086:
;1087:Draw the small two score display
;1088:=================
;1089:*/
;1090:#ifndef MISSIONPACK
;1091:static float CG_DrawScores( float y ) {
line 1100
;1092:	const char	*s;
;1093:	int			s1, s2, score;
;1094:	int			x, w;
;1095:	int			v;
;1096:	vec4_t		color;
;1097:	float		y1;
;1098:	gitem_t		*item;
;1099:
;1100:	s1 = cgs.scores1;
ADDRLP4 28
ADDRGP4 cgs+34800
INDIRI4
ASGNI4
line 1101
;1101:	s2 = cgs.scores2;
ADDRLP4 32
ADDRGP4 cgs+34804
INDIRI4
ASGNI4
line 1103
;1102:
;1103:	y -=  BIGCHAR_HEIGHT + 8;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 1105
;1104:
;1105:	y1 = y;
ADDRLP4 36
ADDRFP4 0
INDIRF4
ASGNF4
line 1108
;1106:
;1107:	// draw from the right side to left
;1108:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $531
line 1109
;1109:		x = 640;
ADDRLP4 16
CNSTI4 640
ASGNI4
line 1110
;1110:		color[0] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1111
;1111:		color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1112
;1112:		color[2] = 1.0f;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 1113
;1113:		color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1114
;1114:		s = va( "%2i", s2 );
ADDRGP4 $537
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 52
INDIRP4
ASGNP4
line 1115
;1115:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 56
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1116
;1116:		x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1117
;1117:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1118
;1118:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $538
line 1119
;1119:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+152340+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1120
;1120:		}
LABELV $538
line 1121
;1121:		CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1123
;1122:
;1123:		if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $543
line 1125
;1124:			// Display flag status
;1125:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 60
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 60
INDIRP4
ASGNP4
line 1127
;1126:
;1127:			if (item) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $546
line 1128
;1128:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 36
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1129
;1129:				if( cgs.blueflag >= 0 && cgs.blueflag <= 2 ) {
ADDRGP4 cgs+34812
INDIRI4
CNSTI4 0
LTI4 $548
ADDRGP4 cgs+34812
INDIRI4
CNSTI4 2
GTI4 $548
line 1130
;1130:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.blueflag] );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34812
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+60
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1131
;1131:				}
LABELV $548
line 1132
;1132:			}
LABELV $546
line 1133
;1133:		}
LABELV $543
line 1134
;1134:		color[0] = 1.0f;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1135
;1135:		color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1136
;1136:		color[2] = 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1137
;1137:		color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1138
;1138:		s = va( "%2i", s1 );
ADDRGP4 $537
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1139
;1139:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1140
;1140:		x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1141
;1141:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1142
;1142:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $558
line 1143
;1143:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+152340+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1144
;1144:		}
LABELV $558
line 1145
;1145:		CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1147
;1146:
;1147:		if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $563
line 1149
;1148:			// Display flag status
;1149:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 68
INDIRP4
ASGNP4
line 1151
;1150:
;1151:			if (item) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $566
line 1152
;1152:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 36
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1153
;1153:				if( cgs.redflag >= 0 && cgs.redflag <= 2 ) {
ADDRGP4 cgs+34808
INDIRI4
CNSTI4 0
LTI4 $568
ADDRGP4 cgs+34808
INDIRI4
CNSTI4 2
GTI4 $568
line 1154
;1154:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.redFlagShader[cgs.redflag] );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34808
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+48
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1155
;1155:				}
LABELV $568
line 1156
;1156:			}
LABELV $566
line 1157
;1157:		}
LABELV $563
line 1172
;1158:
;1159:#ifdef MISSIONPACK
;1160:		if ( cgs.gametype == GT_1FCTF ) {
;1161:			// Display flag status
;1162:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
;1163:
;1164:			if (item) {
;1165:				y1 = y - BIGCHAR_HEIGHT - 8;
;1166:				if( cgs.flagStatus >= 0 && cgs.flagStatus <= 3 ) {
;1167:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.flagShader[cgs.flagStatus] );
;1168:				}
;1169:			}
;1170:		}
;1171:#endif
;1172:		if ( cgs.gametype >= GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
LTI4 $575
line 1173
;1173:			v = cgs.capturelimit;
ADDRLP4 44
ADDRGP4 cgs+31472
INDIRI4
ASGNI4
line 1174
;1174:		} else {
ADDRGP4 $576
JUMPV
LABELV $575
line 1175
;1175:			v = cgs.fraglimit;
ADDRLP4 44
ADDRGP4 cgs+31468
INDIRI4
ASGNI4
line 1176
;1176:		}
LABELV $576
line 1177
;1177:		if ( v ) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $532
line 1178
;1178:			s = va( "%2i", v );
ADDRGP4 $537
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 68
INDIRP4
ASGNP4
line 1179
;1179:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 72
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1180
;1180:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1181
;1181:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1182
;1182:		}
line 1184
;1183:
;1184:	} else {
ADDRGP4 $532
JUMPV
LABELV $531
line 1187
;1185:		qboolean	spectator;
;1186:
;1187:		x = 640;
ADDRLP4 16
CNSTI4 640
ASGNI4
line 1188
;1188:		score = cg.snap->ps.persistant[PERS_SCORE];
ADDRLP4 40
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ASGNI4
line 1189
;1189:		spectator = ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR );
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $585
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRGP4 $586
JUMPV
LABELV $585
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $586
ADDRLP4 52
ADDRLP4 56
INDIRI4
ASGNI4
line 1192
;1190:
;1191:		// always show your score in the second box if not in first place
;1192:		if ( s1 != score ) {
ADDRLP4 28
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $587
line 1193
;1193:			s2 = score;
ADDRLP4 32
ADDRLP4 40
INDIRI4
ASGNI4
line 1194
;1194:		}
LABELV $587
line 1195
;1195:		if ( s2 != SCORE_NOT_PRESENT ) {
ADDRLP4 32
INDIRI4
CNSTI4 -9999
EQI4 $589
line 1196
;1196:			s = va( "%2i", s2 );
ADDRGP4 $537
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1197
;1197:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1198
;1198:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1199
;1199:			if ( !spectator && score == s2 && score != s1 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $591
ADDRLP4 68
ADDRLP4 40
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $591
ADDRLP4 68
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $591
line 1200
;1200:				color[0] = 1.0f;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1201
;1201:				color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1202
;1202:				color[2] = 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1203
;1203:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1204
;1204:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1205
;1205:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+152340+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1206
;1206:			} else {
ADDRGP4 $592
JUMPV
LABELV $591
line 1207
;1207:				color[0] = 0.5f;
ADDRLP4 0
CNSTF4 1056964608
ASGNF4
line 1208
;1208:				color[1] = 0.5f;
ADDRLP4 0+4
CNSTF4 1056964608
ASGNF4
line 1209
;1209:				color[2] = 0.5f;
ADDRLP4 0+8
CNSTF4 1056964608
ASGNF4
line 1210
;1210:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1211
;1211:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1212
;1212:			}	
LABELV $592
line 1213
;1213:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1214
;1214:		}
LABELV $589
line 1217
;1215:
;1216:		// first place
;1217:		if ( s1 != SCORE_NOT_PRESENT ) {
ADDRLP4 28
INDIRI4
CNSTI4 -9999
EQI4 $601
line 1218
;1218:			s = va( "%2i", s1 );
ADDRGP4 $537
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1219
;1219:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1220
;1220:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1221
;1221:			if ( !spectator && score == s1 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $603
ADDRLP4 40
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $603
line 1222
;1222:				color[0] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1223
;1223:				color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1224
;1224:				color[2] = 1.0f;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 1225
;1225:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1226
;1226:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1227
;1227:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+152340+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1228
;1228:			} else {
ADDRGP4 $604
JUMPV
LABELV $603
line 1229
;1229:				color[0] = 0.5f;
ADDRLP4 0
CNSTF4 1056964608
ASGNF4
line 1230
;1230:				color[1] = 0.5f;
ADDRLP4 0+4
CNSTF4 1056964608
ASGNF4
line 1231
;1231:				color[2] = 0.5f;
ADDRLP4 0+8
CNSTF4 1056964608
ASGNF4
line 1232
;1232:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1233
;1233:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1234
;1234:			}	
LABELV $604
line 1235
;1235:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1236
;1236:		}
LABELV $601
line 1238
;1237:
;1238:		if ( cgs.fraglimit ) {
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 0
EQI4 $613
line 1239
;1239:			s = va( "%2i", cgs.fraglimit );
ADDRGP4 $537
ARGP4
ADDRGP4 cgs+31468
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1240
;1240:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1241
;1241:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1242
;1242:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1243
;1243:		}
LABELV $613
line 1245
;1244:
;1245:	}
LABELV $532
line 1247
;1246:
;1247:	return y1 - 8;
ADDRLP4 36
INDIRF4
CNSTF4 1090519040
SUBF4
RETF4
LABELV $528
endproc CG_DrawScores 76 20
data
align 4
LABELV $618
byte 4 1045220557
byte 4 1065353216
byte 4 1045220557
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
code
proc CG_DrawPowerups 208 24
line 1257
;1248:}
;1249:#endif // MISSIONPACK
;1250:
;1251:/*
;1252:================
;1253:CG_DrawPowerups
;1254:================
;1255:*/
;1256:#ifndef MISSIONPACK
;1257:static float CG_DrawPowerups( float y ) {
line 1274
;1258:	int		sorted[MAX_POWERUPS];
;1259:	int		sortedTime[MAX_POWERUPS];
;1260:	int		i, j, k;
;1261:	int		active;
;1262:	playerState_t	*ps;
;1263:	int		t;
;1264:	gitem_t	*item;
;1265:	int		x;
;1266:	int		color;
;1267:	float	size;
;1268:	float	f;
;1269:	static float colors[2][4] = { 
;1270:    { 0.2f, 1.0f, 0.2f, 1.0f } , 
;1271:    { 1.0f, 0.2f, 0.2f, 1.0f } 
;1272:  };
;1273:
;1274:	ps = &cg.snap->ps;
ADDRLP4 148
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 1276
;1275:
;1276:	if ( ps->stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 148
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $620
line 1277
;1277:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $617
JUMPV
LABELV $620
line 1281
;1278:	}
;1279:
;1280:	// sort the list by time remaining
;1281:	active = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
line 1282
;1282:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
LABELV $622
line 1283
;1283:		if ( !ps->powerups[ i ] ) {
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $626
line 1284
;1284:			continue;
ADDRGP4 $623
JUMPV
LABELV $626
line 1286
;1285:		}
;1286:		t = ps->powerups[ i ] - cg.time;
ADDRLP4 140
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 cg+111708
INDIRI4
SUBI4
ASGNI4
line 1289
;1287:		// ZOID--don't draw if the power up has unlimited time (999 seconds)
;1288:		// This is true of the CTF flags
;1289:		if ( t < 0 || t > 999000) {
ADDRLP4 140
INDIRI4
CNSTI4 0
LTI4 $631
ADDRLP4 140
INDIRI4
CNSTI4 999000
LEI4 $629
LABELV $631
line 1290
;1290:			continue;
ADDRGP4 $623
JUMPV
LABELV $629
line 1294
;1291:		}
;1292:
;1293:		// insert into the list
;1294:		for ( j = 0 ; j < active ; j++ ) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $635
JUMPV
LABELV $632
line 1295
;1295:			if ( sortedTime[j] >= t ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $636
line 1296
;1296:				for ( k = active - 1 ; k >= j ; k-- ) {
ADDRLP4 0
ADDRLP4 136
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $641
JUMPV
LABELV $638
line 1297
;1297:					sorted[k+1] = sorted[k];
ADDRLP4 176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 176
INDIRI4
ADDRLP4 68+4
ADDP4
ADDRLP4 176
INDIRI4
ADDRLP4 68
ADDP4
INDIRI4
ASGNI4
line 1298
;1298:					sortedTime[k+1] = sortedTime[k];
ADDRLP4 180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 180
INDIRI4
ADDRLP4 4+4
ADDP4
ADDRLP4 180
INDIRI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
line 1299
;1299:				}
LABELV $639
line 1296
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $641
ADDRLP4 0
INDIRI4
ADDRLP4 132
INDIRI4
GEI4 $638
line 1300
;1300:				break;
ADDRGP4 $634
JUMPV
LABELV $636
line 1302
;1301:			}
;1302:		}
LABELV $633
line 1294
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $635
ADDRLP4 132
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $632
LABELV $634
line 1303
;1303:		sorted[j] = i;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 1304
;1304:		sortedTime[j] = t;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 1305
;1305:		active++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1306
;1306:	}
LABELV $623
line 1282
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 16
LTI4 $622
line 1309
;1307:
;1308:	// draw the icons and timers
;1309:	x = 640 - ICON_SIZE - CHAR_WIDTH * 2;
ADDRLP4 168
CNSTI4 528
ASGNI4
line 1310
;1310:	for ( i = 0 ; i < active ; i++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRGP4 $647
JUMPV
LABELV $644
line 1311
;1311:		item = BG_FindItemForPowerup( sorted[i] );
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 152
ADDRLP4 172
INDIRP4
ASGNP4
line 1313
;1312:
;1313:    if (item) {
ADDRLP4 152
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $648
line 1315
;1314:
;1315:		  color = 1;
ADDRLP4 164
CNSTI4 1
ASGNI4
line 1317
;1316:
;1317:		  y -= ICON_SIZE;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1111490560
SUBF4
ASGNF4
line 1319
;1318:
;1319:		  trap_R_SetColor( colors[color] );
ADDRLP4 164
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $618
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1320
;1320:		  CG_DrawField( x, y, 2, sortedTime[ i ] / 1000, 32, 48 );
ADDRLP4 168
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 176
CNSTI4 2
ASGNI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 144
INDIRI4
ADDRLP4 176
INDIRI4
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
CNSTI4 1000
DIVI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 1322
;1321:
;1322:		  t = ps->powerups[ sorted[i] ];
ADDRLP4 180
CNSTI4 2
ASGNI4
ADDRLP4 140
ADDRLP4 144
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1323
;1323:		  if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
ADDRLP4 140
INDIRI4
ADDRGP4 cg+111708
INDIRI4
SUBI4
CNSTI4 5000
LTI4 $650
line 1324
;1324:			  trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1325
;1325:		  } else {
ADDRGP4 $651
JUMPV
LABELV $650
line 1328
;1326:			  vec4_t	modulate;
;1327:
;1328:			  f = (float)( t - cg.time ) / POWERUP_BLINK_TIME;
ADDRLP4 160
ADDRLP4 140
INDIRI4
ADDRGP4 cg+111708
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 1329
;1329:			  f -= (int)f;
ADDRLP4 160
ADDRLP4 160
INDIRF4
ADDRLP4 160
INDIRF4
CVFI4 4
CVIF4 4
SUBF4
ASGNF4
line 1330
;1330:			  modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
ADDRLP4 184+12
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184+8
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184
ADDRLP4 160
INDIRF4
ASGNF4
line 1331
;1331:			  trap_R_SetColor( modulate );
ADDRLP4 184
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1332
;1332:		  }
LABELV $651
line 1334
;1333:
;1334:		  if ( cg.powerupActive == sorted[i] && 
ADDRGP4 cg+128524
INDIRI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
NEI4 $657
ADDRGP4 cg+111708
INDIRI4
ADDRGP4 cg+128528
INDIRI4
SUBI4
CNSTI4 200
GEI4 $657
line 1335
;1335:			  cg.time - cg.powerupTime < PULSE_TIME ) {
line 1336
;1336:			  f = 1.0 - ( ( (float)cg.time - cg.powerupTime ) / PULSE_TIME );
ADDRLP4 160
CNSTF4 1065353216
ADDRGP4 cg+111708
INDIRI4
CVIF4 4
ADDRGP4 cg+128528
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1128792064
DIVF4
SUBF4
ASGNF4
line 1337
;1337:			  size = ICON_SIZE * ( 1.0 + ( PULSE_SCALE - 1.0 ) * f );
ADDRLP4 156
CNSTF4 1111490560
CNSTF4 1056964608
ADDRLP4 160
INDIRF4
MULF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 1338
;1338:		  } else {
ADDRGP4 $658
JUMPV
LABELV $657
line 1339
;1339:			  size = ICON_SIZE;
ADDRLP4 156
CNSTF4 1111490560
ASGNF4
line 1340
;1340:		  }
LABELV $658
line 1342
;1341:
;1342:		  CG_DrawPic( 640 - size, y + ICON_SIZE / 2 - size / 2, 
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
CNSTF4 1142947840
ADDRLP4 156
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
ADDF4
ADDRLP4 156
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1344
;1343:			  size, size, trap_R_RegisterShader( item->icon ) );
;1344:    }
LABELV $648
line 1345
;1345:	}
LABELV $645
line 1310
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $647
ADDRLP4 144
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $644
line 1346
;1346:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1348
;1347:
;1348:	return y;
ADDRFP4 0
INDIRF4
RETF4
LABELV $617
endproc CG_DrawPowerups 208 24
proc CG_DrawLowerRight 12 12
line 1359
;1349:}
;1350:#endif // MISSIONPACK
;1351:
;1352:/*
;1353:=====================
;1354:CG_DrawLowerRight
;1355:
;1356:=====================
;1357:*/
;1358:#ifndef MISSIONPACK
;1359:static void CG_DrawLowerRight( void ) {
line 1362
;1360:	float	y;
;1361:
;1362:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 1364
;1363:
;1364:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 2 ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $665
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 2
NEI4 $665
line 1365
;1365:		y = CG_DrawTeamOverlay( y, qtrue, qfalse );
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1366
;1366:	} 
LABELV $665
line 1368
;1367:
;1368:	y = CG_DrawScores( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawScores
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1369
;1369:	y = CG_DrawPowerups( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawPowerups
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1370
;1370:}
LABELV $664
endproc CG_DrawLowerRight 12 12
proc CG_DrawPickupItem 16 20
line 1379
;1371:#endif // MISSIONPACK
;1372:
;1373:/*
;1374:===================
;1375:CG_DrawPickupItem
;1376:===================
;1377:*/
;1378:#ifndef MISSIONPACK
;1379:static int CG_DrawPickupItem( int y ) {
line 1383
;1380:	int		value;
;1381:	float	*fadeColor;
;1382:
;1383:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $670
line 1384
;1384:		return y;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $669
JUMPV
LABELV $670
line 1387
;1385:	}
;1386:
;1387:	y -= ICON_SIZE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 48
SUBI4
ASGNI4
line 1389
;1388:
;1389:	value = cg.itemPickup;
ADDRLP4 0
ADDRGP4 cg+128780
INDIRI4
ASGNI4
line 1390
;1390:	if ( value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $674
line 1391
;1391:		fadeColor = CG_FadeColor( cg.itemPickupTime, 3000 );
ADDRGP4 cg+128784
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 8
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 1392
;1392:		if ( fadeColor ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $677
line 1393
;1393:			CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1394
;1394:			trap_R_SetColor( fadeColor );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1395
;1395:			CG_DrawPic( 8, y, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
CNSTF4 1090519040
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1396
;1396:			CG_DrawBigString( ICON_SIZE + 16, y + (ICON_SIZE/2 - BIGCHAR_HEIGHT/2), bg_itemlist[ value ].pickup_name, fadeColor[0] );
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 16
ADDI4
ARGI4
CNSTI4 52
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+28
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1397
;1397:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1398
;1398:		}
LABELV $677
line 1399
;1399:	}
LABELV $674
line 1401
;1400:	
;1401:	return y;
ADDRFP4 0
INDIRI4
RETI4
LABELV $669
endproc CG_DrawPickupItem 16 20
proc CG_DrawLowerLeft 16 12
line 1412
;1402:}
;1403:#endif // MISSIONPACK
;1404:
;1405:/*
;1406:=====================
;1407:CG_DrawLowerLeft
;1408:
;1409:=====================
;1410:*/
;1411:#ifndef MISSIONPACK
;1412:static void CG_DrawLowerLeft( void ) {
line 1415
;1413:	float	y;
;1414:
;1415:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 1417
;1416:
;1417:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 3 ) {
ADDRLP4 4
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $682
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $682
line 1418
;1418:		y = CG_DrawTeamOverlay( y, qfalse, qfalse );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1419
;1419:	} 
LABELV $682
line 1422
;1420:
;1421:
;1422:	y = CG_DrawPickupItem( y );
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawPickupItem
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
line 1423
;1423:}
LABELV $681
endproc CG_DrawLowerLeft 16 12
proc CG_DrawTeamInfo 56 36
line 1435
;1424:#endif // MISSIONPACK
;1425:
;1426:
;1427://===========================================================================================
;1428:
;1429:/*
;1430:=================
;1431:CG_DrawTeamInfo
;1432:=================
;1433:*/
;1434:#ifndef MISSIONPACK
;1435:static void CG_DrawTeamInfo( void ) {
line 1444
;1436:	int w, h;
;1437:	int i, len;
;1438:	vec4_t		hcolor;
;1439:	int		chatHeight;
;1440:
;1441:#define CHATLOC_Y 420 // bottom end
;1442:#define CHATLOC_X 0
;1443:
;1444:	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT)
ADDRGP4 cg_teamChatHeight+12
INDIRI4
CNSTI4 8
GEI4 $687
line 1445
;1445:		chatHeight = cg_teamChatHeight.integer;
ADDRLP4 8
ADDRGP4 cg_teamChatHeight+12
INDIRI4
ASGNI4
ADDRGP4 $688
JUMPV
LABELV $687
line 1447
;1446:	else
;1447:		chatHeight = TEAMCHAT_HEIGHT;
ADDRLP4 8
CNSTI4 8
ASGNI4
LABELV $688
line 1448
;1448:	if (chatHeight <= 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $691
line 1449
;1449:		return; // disabled
ADDRGP4 $686
JUMPV
LABELV $691
line 1451
;1450:
;1451:	if (cgs.teamLastChatPos != cgs.teamChatPos) {
ADDRGP4 cgs+152248
INDIRI4
ADDRGP4 cgs+152244
INDIRI4
EQI4 $693
line 1452
;1452:		if (cg.time - cgs.teamChatMsgTimes[cgs.teamLastChatPos % chatHeight] > cg_teamChatTime.integer) {
ADDRGP4 cg+111708
INDIRI4
ADDRGP4 cgs+152248
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152212
ADDP4
INDIRI4
SUBI4
ADDRGP4 cg_teamChatTime+12
INDIRI4
LEI4 $697
line 1453
;1453:			cgs.teamLastChatPos++;
ADDRLP4 36
ADDRGP4 cgs+152248
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1454
;1454:		}
LABELV $697
line 1456
;1455:
;1456:		h = (cgs.teamChatPos - cgs.teamLastChatPos) * TINYCHAR_HEIGHT;
ADDRLP4 32
ADDRGP4 cgs+152244
INDIRI4
ADDRGP4 cgs+152248
INDIRI4
SUBI4
CNSTI4 3
LSHI4
ASGNI4
line 1458
;1457:
;1458:		w = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 1460
;1459:
;1460:		for (i = cgs.teamLastChatPos; i < cgs.teamChatPos; i++) {
ADDRLP4 0
ADDRGP4 cgs+152248
INDIRI4
ASGNI4
ADDRGP4 $709
JUMPV
LABELV $706
line 1461
;1461:			len = CG_DrawStrlen(cgs.teamChatMsgs[i % chatHeight]);
CNSTI4 241
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+150284
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 36
INDIRI4
ASGNI4
line 1462
;1462:			if (len > w)
ADDRLP4 4
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $713
line 1463
;1463:				w = len;
ADDRLP4 28
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $713
line 1464
;1464:		}
LABELV $707
line 1460
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $709
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+152244
INDIRI4
LTI4 $706
line 1465
;1465:		w *= TINYCHAR_WIDTH;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1466
;1466:		w += TINYCHAR_WIDTH * 2;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1468
;1467:
;1468:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $715
line 1469
;1469:			hcolor[0] = 1.0f;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1470
;1470:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1471
;1471:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1472
;1472:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1473
;1473:		} else if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 $716
JUMPV
LABELV $715
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $721
line 1474
;1474:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1475
;1475:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1476
;1476:			hcolor[2] = 1.0f;
ADDRLP4 12+8
CNSTF4 1065353216
ASGNF4
line 1477
;1477:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1478
;1478:		} else {
ADDRGP4 $722
JUMPV
LABELV $721
line 1479
;1479:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1480
;1480:			hcolor[1] = 1.0f;
ADDRLP4 12+4
CNSTF4 1065353216
ASGNF4
line 1481
;1481:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1482
;1482:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1483
;1483:		}
LABELV $722
LABELV $716
line 1485
;1484:
;1485:		trap_R_SetColor( hcolor );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1486
;1486:		CG_DrawPic( CHATLOC_X, CHATLOC_Y - h, 640, h, cgs.media.teamStatusBar );
CNSTF4 0
ARGF4
ADDRLP4 36
ADDRLP4 32
INDIRI4
ASGNI4
CNSTI4 420
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1142947840
ARGF4
ADDRLP4 36
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+152340+128
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1487
;1487:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1489
;1488:
;1489:		hcolor[0] = hcolor[1] = hcolor[2] = 1.0f;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
ADDRLP4 12+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 40
INDIRF4
ASGNF4
line 1490
;1490:		hcolor[3] = 1.0f;
ADDRLP4 12+12
CNSTF4 1065353216
ASGNF4
line 1492
;1491:
;1492:		for (i = cgs.teamChatPos - 1; i >= cgs.teamLastChatPos; i--) {
ADDRLP4 0
ADDRGP4 cgs+152244
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $738
JUMPV
LABELV $735
line 1493
;1493:			CG_DrawStringExt( CHATLOC_X + TINYCHAR_WIDTH, 
ADDRLP4 44
CNSTI4 8
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 420
ADDRGP4 cgs+152244
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 3
LSHI4
SUBI4
ARGI4
CNSTI4 241
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+150284
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1497
;1494:				CHATLOC_Y - (cgs.teamChatPos - i)*TINYCHAR_HEIGHT, 
;1495:				cgs.teamChatMsgs[i % chatHeight], hcolor, qfalse, qfalse,
;1496:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0 );
;1497:		}
LABELV $736
line 1492
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $738
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+152248
INDIRI4
GEI4 $735
line 1498
;1498:	}
LABELV $693
line 1499
;1499:}
LABELV $686
endproc CG_DrawTeamInfo 56 36
proc CG_DrawHoldableItem 8 20
line 1508
;1500:#endif // MISSIONPACK
;1501:
;1502:/*
;1503:===================
;1504:CG_DrawHoldableItem
;1505:===================
;1506:*/
;1507:#ifndef MISSIONPACK
;1508:static void CG_DrawHoldableItem( void ) { 
line 1511
;1509:	int		value;
;1510:
;1511:	value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 1512
;1512:	if ( value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $745
line 1513
;1513:		CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1514
;1514:		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
CNSTF4 1142161408
ARGF4
CNSTF4 1129840640
ARGF4
ADDRLP4 4
CNSTF4 1111490560
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1515
;1515:	}
LABELV $745
line 1517
;1516:
;1517:}
LABELV $743
endproc CG_DrawHoldableItem 8 20
proc CG_DrawReward 68 36
line 1545
;1518:#endif // MISSIONPACK
;1519:
;1520:#ifdef MISSIONPACK
;1521:/*
;1522:===================
;1523:CG_DrawPersistantPowerup
;1524:===================
;1525:*/
;1526:#if 0 // sos001208 - DEAD
;1527:static void CG_DrawPersistantPowerup( void ) { 
;1528:	int		value;
;1529:
;1530:	value = cg.snap->ps.stats[STAT_PERSISTANT_POWERUP];
;1531:	if ( value ) {
;1532:		CG_RegisterItemVisuals( value );
;1533:		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2 - ICON_SIZE, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
;1534:	}
;1535:}
;1536:#endif
;1537:#endif // MISSIONPACK
;1538:
;1539:
;1540:/*
;1541:===================
;1542:CG_DrawReward
;1543:===================
;1544:*/
;1545:static void CG_DrawReward( void ) { 
line 1551
;1546:	float	*color;
;1547:	int		i, count;
;1548:	float	x, y;
;1549:	char	buf[32];
;1550:
;1551:	if ( !cg_drawRewards.integer ) {
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 0
NEI4 $749
line 1552
;1552:		return;
ADDRGP4 $748
JUMPV
LABELV $749
line 1555
;1553:	}
;1554:
;1555:	color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+128544
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 52
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 52
INDIRP4
ASGNP4
line 1556
;1556:	if ( !color ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $753
line 1557
;1557:		if (cg.rewardStack > 0) {
ADDRGP4 cg+128540
INDIRI4
CNSTI4 0
LEI4 $748
line 1558
;1558:			for(i = 0; i < cg.rewardStack; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $761
JUMPV
LABELV $758
line 1559
;1559:				cg.rewardSound[i] = cg.rewardSound[i+1];
ADDRLP4 56
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
INDIRI4
ADDRGP4 cg+128628
ADDP4
ADDRLP4 56
INDIRI4
ADDRGP4 cg+128628+4
ADDP4
INDIRI4
ASGNI4
line 1560
;1560:				cg.rewardShader[i] = cg.rewardShader[i+1];
ADDRLP4 60
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 60
INDIRI4
ADDRGP4 cg+128588
ADDP4
ADDRLP4 60
INDIRI4
ADDRGP4 cg+128588+4
ADDP4
INDIRI4
ASGNI4
line 1561
;1561:				cg.rewardCount[i] = cg.rewardCount[i+1];
ADDRLP4 64
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRGP4 cg+128548
ADDP4
ADDRLP4 64
INDIRI4
ADDRGP4 cg+128548+4
ADDP4
INDIRI4
ASGNI4
line 1562
;1562:			}
LABELV $759
line 1558
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $761
ADDRLP4 0
INDIRI4
ADDRGP4 cg+128540
INDIRI4
LTI4 $758
line 1563
;1563:			cg.rewardTime = cg.time;
ADDRGP4 cg+128544
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 1564
;1564:			cg.rewardStack--;
ADDRLP4 56
ADDRGP4 cg+128540
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1565
;1565:			color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+128544
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 60
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 60
INDIRP4
ASGNP4
line 1566
;1566:			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
ADDRGP4 cg+128628
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1567
;1567:		} else {
line 1568
;1568:			return;
LABELV $756
line 1570
;1569:		}
;1570:	}
LABELV $753
line 1572
;1571:
;1572:	trap_R_SetColor( color );
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1589
;1573:
;1574:	/*
;1575:	count = cg.rewardCount[0]/10;				// number of big rewards to draw
;1576:
;1577:	if (count) {
;1578:		y = 4;
;1579:		x = 320 - count * ICON_SIZE;
;1580:		for ( i = 0 ; i < count ; i++ ) {
;1581:			CG_DrawPic( x, y, (ICON_SIZE*2)-4, (ICON_SIZE*2)-4, cg.rewardShader[0] );
;1582:			x += (ICON_SIZE*2);
;1583:		}
;1584:	}
;1585:
;1586:	count = cg.rewardCount[0] - count*10;		// number of small rewards to draw
;1587:	*/
;1588:
;1589:	if ( cg.rewardCount[0] >= 10 ) {
ADDRGP4 cg+128548
INDIRI4
CNSTI4 10
LTI4 $777
line 1590
;1590:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 1591
;1591:		x = 320 - ICON_SIZE/2;
ADDRLP4 4
CNSTF4 1133772800
ASGNF4
line 1592
;1592:		CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1110441984
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cg+128588
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1593
;1593:		Com_sprintf(buf, sizeof(buf), "%d", cg.rewardCount[0]);
ADDRLP4 20
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $781
ARGP4
ADDRGP4 cg+128548
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1594
;1594:		x = ( SCREEN_WIDTH - SMALLCHAR_WIDTH * CG_DrawStrlen( buf ) ) / 2;
ADDRLP4 20
ARGP4
ADDRLP4 60
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
CNSTI4 640
ADDRLP4 60
INDIRI4
CNSTI4 3
LSHI4
SUBI4
CNSTI4 2
DIVI4
CVIF4 4
ASGNF4
line 1595
;1595:		CG_DrawStringExt( x, y+ICON_SIZE, buf, color, qfalse, qtrue,
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRF4
CNSTF4 1111490560
ADDF4
CVFI4 4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1597
;1596:								SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0 );
;1597:	}
ADDRGP4 $778
JUMPV
LABELV $777
line 1598
;1598:	else {
line 1600
;1599:
;1600:		count = cg.rewardCount[0];
ADDRLP4 12
ADDRGP4 cg+128548
INDIRI4
ASGNI4
line 1602
;1601:
;1602:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 1603
;1603:		x = 320 - count * ICON_SIZE/2;
ADDRLP4 4
CNSTI4 320
CNSTI4 48
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ASGNF4
line 1604
;1604:		for ( i = 0 ; i < count ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $787
JUMPV
LABELV $784
line 1605
;1605:			CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1110441984
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cg+128588
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1606
;1606:			x += ICON_SIZE;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 1607
;1607:		}
LABELV $785
line 1604
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $787
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $784
line 1608
;1608:	}
LABELV $778
line 1609
;1609:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1610
;1610:}
LABELV $748
endproc CG_DrawReward 68 36
export CG_AddLagometerFrameInfo
proc CG_AddLagometerFrameInfo 8 0
line 1641
;1611:
;1612:
;1613:/*
;1614:===============================================================================
;1615:
;1616:LAGOMETER
;1617:
;1618:===============================================================================
;1619:*/
;1620:
;1621:#define	LAG_SAMPLES		128
;1622:
;1623:
;1624:typedef struct {
;1625:	int		frameSamples[LAG_SAMPLES];
;1626:	int		frameCount;
;1627:	int		snapshotFlags[LAG_SAMPLES];
;1628:	int		snapshotSamples[LAG_SAMPLES];
;1629:	int		snapshotCount;
;1630:} lagometer_t;
;1631:
;1632:lagometer_t		lagometer;
;1633:
;1634:/*
;1635:==============
;1636:CG_AddLagometerFrameInfo
;1637:
;1638:Adds the current interpolate / extrapolate bar for this frame
;1639:==============
;1640:*/
;1641:void CG_AddLagometerFrameInfo( void ) {
line 1644
;1642:	int			offset;
;1643:
;1644:	offset = cg.time - cg.latestSnapshotTime;
ADDRLP4 0
ADDRGP4 cg+111708
INDIRI4
ADDRGP4 cg+32
INDIRI4
SUBI4
ASGNI4
line 1645
;1645:	lagometer.frameSamples[ lagometer.frameCount & ( LAG_SAMPLES - 1) ] = offset;
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1646
;1646:	lagometer.frameCount++;
ADDRLP4 4
ADDRGP4 lagometer+512
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1647
;1647:}
LABELV $790
endproc CG_AddLagometerFrameInfo 8 0
export CG_AddLagometerSnapshotInfo
proc CG_AddLagometerSnapshotInfo 4 0
line 1659
;1648:
;1649:/*
;1650:==============
;1651:CG_AddLagometerSnapshotInfo
;1652:
;1653:Each time a snapshot is received, log its ping time and
;1654:the number of snapshots that were dropped before it.
;1655:
;1656:Pass NULL for a dropped packet.
;1657:==============
;1658:*/
;1659:void CG_AddLagometerSnapshotInfo( snapshot_t *snap ) {
line 1661
;1660:	// dropped packet
;1661:	if ( !snap ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $796
line 1662
;1662:		lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = -1;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
CNSTI4 -1
ASGNI4
line 1663
;1663:		lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1664
;1664:		return;
ADDRGP4 $795
JUMPV
LABELV $796
line 1668
;1665:	}
;1666:
;1667:	// add this snapshot's info
;1668:	lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->ping;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1669
;1669:	lagometer.snapshotFlags[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->snapFlags;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1670
;1670:	lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1671
;1671:}
LABELV $795
endproc CG_AddLagometerSnapshotInfo 4 0
proc CG_DrawDisconnect 64 20
line 1680
;1672:
;1673:/*
;1674:==============
;1675:CG_DrawDisconnect
;1676:
;1677:Should we draw something differnet for long lag vs no packets?
;1678:==============
;1679:*/
;1680:static void CG_DrawDisconnect( void ) {
line 1688
;1681:	float		x, y;
;1682:	int			cmdNum;
;1683:	usercmd_t	cmd;
;1684:	const char		*s;
;1685:	int			w;  // bk010215 - FIXME char message[1024];
;1686:
;1687:	// draw the phone jack if we are completely past our buffers
;1688:	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
ADDRLP4 44
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 44
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1689
;1689:	trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 1690
;1690:	if ( cmd.serverTime <= cg.snap->ps.commandTime
ADDRLP4 48
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $811
ADDRLP4 48
INDIRI4
ADDRGP4 cg+111708
INDIRI4
LEI4 $807
LABELV $811
line 1691
;1691:		|| cmd.serverTime > cg.time ) {	// special check for map_restart // bk 0102165 - FIXME
line 1692
;1692:		return;
ADDRGP4 $806
JUMPV
LABELV $807
line 1696
;1693:	}
;1694:
;1695:	// also add text in center of screen
;1696:	s = "Connection Interrupted"; // bk 010215 - FIXME
ADDRLP4 24
ADDRGP4 $812
ASGNP4
line 1697
;1697:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1698
;1698:	CG_DrawBigString( 320 - w/2, 100, s, 1.0F);
CNSTI4 320
ADDRLP4 40
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1701
;1699:
;1700:	// blink the icon
;1701:	if ( ( cg.time >> 9 ) & 1 ) {
ADDRGP4 cg+111708
INDIRI4
CNSTI4 9
RSHI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $813
line 1702
;1702:		return;
ADDRGP4 $806
JUMPV
LABELV $813
line 1705
;1703:	}
;1704:
;1705:	x = 640 - 48;
ADDRLP4 28
CNSTF4 1142161408
ASGNF4
line 1706
;1706:	y = 480 - 48;
ADDRLP4 32
CNSTF4 1138229248
ASGNF4
line 1708
;1707:
;1708:	CG_DrawPic( x, y, 48, 48, trap_R_RegisterShader("gfx/2d/net.tga" ) );
ADDRGP4 $816
ARGP4
ADDRLP4 56
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 1111490560
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1709
;1709:}
LABELV $806
endproc CG_DrawDisconnect 64 20
proc CG_DrawLagometer 68 36
line 1720
;1710:
;1711:
;1712:#define	MAX_LAGOMETER_PING	900
;1713:#define	MAX_LAGOMETER_RANGE	300
;1714:
;1715:/*
;1716:==============
;1717:CG_DrawLagometer
;1718:==============
;1719:*/
;1720:static void CG_DrawLagometer( void ) {
line 1727
;1721:	int		a, x, y, i;
;1722:	float	v;
;1723:	float	ax, ay, aw, ah, mid, range;
;1724:	int		color;
;1725:	float	vscale;
;1726:
;1727:	if ( !cg_lagometer.integer || cgs.localServer ) {
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRGP4 cg_lagometer+12
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $822
ADDRGP4 cgs+31452
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $818
LABELV $822
line 1728
;1728:		CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 1729
;1729:		return;
ADDRGP4 $817
JUMPV
LABELV $818
line 1739
;1730:	}
;1731:
;1732:	//
;1733:	// draw the graph
;1734:	//
;1735:#ifdef MISSIONPACK
;1736:	x = 640 - 48;
;1737:	y = 480 - 144;
;1738:#else
;1739:	x = 640 - 48;
ADDRLP4 44
CNSTI4 592
ASGNI4
line 1740
;1740:	y = 480 - 48;
ADDRLP4 48
CNSTI4 432
ASGNI4
line 1743
;1741:#endif
;1742:
;1743:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1744
;1744:	CG_DrawPic( x, y, 48, 48, cgs.media.lagometerShader );
ADDRLP4 44
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 48
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
CNSTF4 1111490560
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cgs+152340+264
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1746
;1745:
;1746:	ax = x;
ADDRLP4 24
ADDRLP4 44
INDIRI4
CVIF4 4
ASGNF4
line 1747
;1747:	ay = y;
ADDRLP4 36
ADDRLP4 48
INDIRI4
CVIF4 4
ASGNF4
line 1748
;1748:	aw = 48;
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
line 1749
;1749:	ah = 48;
ADDRLP4 32
CNSTF4 1111490560
ASGNF4
line 1750
;1750:	CG_AdjustFrom640( &ax, &ay, &aw, &ah );
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 1752
;1751:
;1752:	color = -1;
ADDRLP4 20
CNSTI4 -1
ASGNI4
line 1753
;1753:	range = ah / 3;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1077936128
DIVF4
ASGNF4
line 1754
;1754:	mid = ay + range;
ADDRLP4 40
ADDRLP4 36
INDIRF4
ADDRLP4 16
INDIRF4
ADDF4
ASGNF4
line 1756
;1755:
;1756:	vscale = range / MAX_LAGOMETER_RANGE;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 1133903872
DIVF4
ASGNF4
line 1759
;1757:
;1758:	// draw the frame interpoalte / extrapolate graph
;1759:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $828
JUMPV
LABELV $825
line 1760
;1760:		i = ( lagometer.frameCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 1761
;1761:		v = lagometer.frameSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1762
;1762:		v *= vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1763
;1763:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $830
line 1764
;1764:			if ( color != 1 ) {
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $832
line 1765
;1765:				color = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 1766
;1766:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1767
;1767:			}
LABELV $832
line 1768
;1768:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $835
line 1769
;1769:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1770
;1770:			}
LABELV $835
line 1771
;1771:			trap_R_DrawStretchPic ( ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
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
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1772
;1772:		} else if ( v < 0 ) {
ADDRGP4 $831
JUMPV
LABELV $830
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $839
line 1773
;1773:			if ( color != 2 ) {
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $841
line 1774
;1774:				color = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 1775
;1775:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_BLUE)] );
ADDRGP4 g_color_table+64
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1776
;1776:			}
LABELV $841
line 1777
;1777:			v = -v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
line 1778
;1778:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $844
line 1779
;1779:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1780
;1780:			}
LABELV $844
line 1781
;1781:			trap_R_DrawStretchPic( ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1782
;1782:		}
LABELV $839
LABELV $831
line 1783
;1783:	}
LABELV $826
line 1759
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $828
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $825
line 1786
;1784:
;1785:	// draw the snapshot latency / drop graph
;1786:	range = ah / 2;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 1787
;1787:	vscale = range / MAX_LAGOMETER_PING;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 1147207680
DIVF4
ASGNF4
line 1789
;1788:
;1789:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $851
JUMPV
LABELV $848
line 1790
;1790:		i = ( lagometer.snapshotCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 1791
;1791:		v = lagometer.snapshotSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1792
;1792:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $854
line 1793
;1793:			if ( lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED ) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $856
line 1794
;1794:				if ( color != 5 ) {
ADDRLP4 20
INDIRI4
CNSTI4 5
EQI4 $857
line 1795
;1795:					color = 5;	// YELLOW for rate delay
ADDRLP4 20
CNSTI4 5
ASGNI4
line 1796
;1796:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1797
;1797:				}
line 1798
;1798:			} else {
ADDRGP4 $857
JUMPV
LABELV $856
line 1799
;1799:				if ( color != 3 ) {
ADDRLP4 20
INDIRI4
CNSTI4 3
EQI4 $862
line 1800
;1800:					color = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 1801
;1801:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_GREEN)] );
ADDRGP4 g_color_table+32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1802
;1802:				}
LABELV $862
line 1803
;1803:			}
LABELV $857
line 1804
;1804:			v = v * vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1805
;1805:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $865
line 1806
;1806:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1807
;1807:			}
LABELV $865
line 1808
;1808:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
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
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1809
;1809:		} else if ( v < 0 ) {
ADDRGP4 $855
JUMPV
LABELV $854
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $869
line 1810
;1810:			if ( color != 4 ) {
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $871
line 1811
;1811:				color = 4;		// RED for dropped snapshots
ADDRLP4 20
CNSTI4 4
ASGNI4
line 1812
;1812:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_RED)] );
ADDRGP4 g_color_table+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1813
;1813:			}
LABELV $871
line 1814
;1814:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
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
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1815
;1815:		}
LABELV $869
LABELV $855
line 1816
;1816:	}
LABELV $849
line 1789
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $851
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $848
line 1818
;1817:
;1818:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1820
;1819:
;1820:	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $880
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $876
LABELV $880
line 1821
;1821:		CG_DrawBigString( ax, ay, "snc", 1.0 );
ADDRLP4 24
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 36
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 $881
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1822
;1822:	}
LABELV $876
line 1824
;1823:
;1824:	CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 1825
;1825:}
LABELV $817
endproc CG_DrawLagometer 68 36
export CG_CenterPrint
proc CG_CenterPrint 8 12
line 1846
;1826:
;1827:
;1828:
;1829:/*
;1830:===============================================================================
;1831:
;1832:CENTER PRINTING
;1833:
;1834:===============================================================================
;1835:*/
;1836:
;1837:
;1838:/*
;1839:==============
;1840:CG_CenterPrint
;1841:
;1842:Called for important messages that should stay in the center of the screen
;1843:for a few moments
;1844:==============
;1845:*/
;1846:void CG_CenterPrint( const char *str, int y, int charWidth ) {
line 1849
;1847:	char	*s;
;1848:
;1849:	Q_strncpyz( cg.centerPrint, str, sizeof(cg.centerPrint) );
ADDRGP4 cg+127480
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1851
;1850:
;1851:	cg.centerPrintTime = cg.time;
ADDRGP4 cg+127468
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 1852
;1852:	cg.centerPrintY = y;
ADDRGP4 cg+127476
ADDRFP4 4
INDIRI4
ASGNI4
line 1853
;1853:	cg.centerPrintCharWidth = charWidth;
ADDRGP4 cg+127472
ADDRFP4 8
INDIRI4
ASGNI4
line 1856
;1854:
;1855:	// count the number of lines for centering
;1856:	cg.centerPrintLines = 1;
ADDRGP4 cg+128504
CNSTI4 1
ASGNI4
line 1857
;1857:	s = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+127480
ASGNP4
ADDRGP4 $892
JUMPV
LABELV $891
line 1858
;1858:	while( *s ) {
line 1859
;1859:		if (*s == '\n')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $894
line 1860
;1860:			cg.centerPrintLines++;
ADDRLP4 4
ADDRGP4 cg+128504
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $894
line 1861
;1861:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1862
;1862:	}
LABELV $892
line 1858
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $891
line 1863
;1863:}
LABELV $882
endproc CG_CenterPrint 8 12
proc CG_DrawCenterString 1064 36
line 1871
;1864:
;1865:
;1866:/*
;1867:===================
;1868:CG_DrawCenterString
;1869:===================
;1870:*/
;1871:static void CG_DrawCenterString( void ) {
line 1880
;1872:	char	*start;
;1873:	int		l;
;1874:	int		x, y, w;
;1875:#ifdef MISSIONPACK // bk010221 - unused else
;1876:  int h;
;1877:#endif
;1878:	float	*color;
;1879:
;1880:	if ( !cg.centerPrintTime ) {
ADDRGP4 cg+127468
INDIRI4
CNSTI4 0
NEI4 $898
line 1881
;1881:		return;
ADDRGP4 $897
JUMPV
LABELV $898
line 1884
;1882:	}
;1883:
;1884:	color = CG_FadeColor( cg.centerPrintTime, 1000 * cg_centertime.value );
ADDRGP4 cg+127468
INDIRI4
ARGI4
CNSTF4 1148846080
ADDRGP4 cg_centertime+8
INDIRF4
MULF4
CVFI4 4
ARGI4
ADDRLP4 24
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
ASGNP4
line 1885
;1885:	if ( !color ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $903
line 1886
;1886:		return;
ADDRGP4 $897
JUMPV
LABELV $903
line 1889
;1887:	}
;1888:
;1889:	trap_R_SetColor( color );
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1891
;1890:
;1891:	start = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+127480
ASGNP4
line 1893
;1892:
;1893:	y = cg.centerPrintY - cg.centerPrintLines * BIGCHAR_HEIGHT / 2;
ADDRLP4 8
ADDRGP4 cg+127476
INDIRI4
ADDRGP4 cg+128504
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
ADDRGP4 $909
JUMPV
LABELV $908
line 1895
;1894:
;1895:	while ( 1 ) {
line 1898
;1896:		char linebuffer[1024];
;1897:
;1898:		for ( l = 0; l < 50; l++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $911
line 1899
;1899:			if ( !start[l] || start[l] == '\n' ) {
ADDRLP4 1052
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $917
ADDRLP4 1052
INDIRI4
CNSTI4 10
NEI4 $915
LABELV $917
line 1900
;1900:				break;
ADDRGP4 $913
JUMPV
LABELV $915
line 1902
;1901:			}
;1902:			linebuffer[l] = start[l];
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 1903
;1903:		}
LABELV $912
line 1898
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 50
LTI4 $911
LABELV $913
line 1904
;1904:		linebuffer[l] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
CNSTI1 0
ASGNI1
line 1913
;1905:
;1906:#ifdef MISSIONPACK
;1907:		w = CG_Text_Width(linebuffer, 0.5, 0);
;1908:		h = CG_Text_Height(linebuffer, 0.5, 0);
;1909:		x = (SCREEN_WIDTH - w) / 2;
;1910:		CG_Text_Paint(x, y + h, 0.5, color, linebuffer, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;1911:		y += h + 6;
;1912:#else
;1913:		w = cg.centerPrintCharWidth * CG_DrawStrlen( linebuffer );
ADDRLP4 28
ARGP4
ADDRLP4 1052
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRGP4 cg+127472
INDIRI4
ADDRLP4 1052
INDIRI4
MULI4
ASGNI4
line 1915
;1914:
;1915:		x = ( SCREEN_WIDTH - w ) / 2;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 1917
;1916:
;1917:		CG_DrawStringExt( x, y, linebuffer, color, qfalse, qtrue,
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRLP4 1056
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cg+127472
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRGP4 cg+127472
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1920
;1918:			cg.centerPrintCharWidth, (int)(cg.centerPrintCharWidth * 1.5), 0 );
;1919:
;1920:		y += cg.centerPrintCharWidth * 1.5;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CVIF4 4
CNSTF4 1069547520
ADDRGP4 cg+127472
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
ADDRGP4 $923
JUMPV
LABELV $922
line 1922
;1921:#endif
;1922:		while ( *start && ( *start != '\n' ) ) {
line 1923
;1923:			start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1924
;1924:		}
LABELV $923
line 1922
ADDRLP4 1060
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $925
ADDRLP4 1060
INDIRI4
CNSTI4 10
NEI4 $922
LABELV $925
line 1925
;1925:		if ( !*start ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $926
line 1926
;1926:			break;
ADDRGP4 $910
JUMPV
LABELV $926
line 1928
;1927:		}
;1928:		start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1929
;1929:	}
LABELV $909
line 1895
ADDRGP4 $908
JUMPV
LABELV $910
line 1931
;1930:
;1931:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1932
;1932:}
LABELV $897
endproc CG_DrawCenterString 1064 36
proc CG_DrawCrosshair 56 36
line 1950
;1933:
;1934:
;1935:
;1936:/*
;1937:================================================================================
;1938:
;1939:CROSSHAIR
;1940:
;1941:================================================================================
;1942:*/
;1943:
;1944:
;1945:/*
;1946:=================
;1947:CG_DrawCrosshair
;1948:=================
;1949:*/
;1950:static void CG_DrawCrosshair(void) {
line 1957
;1951:	float		w, h;
;1952:	qhandle_t	hShader;
;1953:	float		f;
;1954:	float		x, y;
;1955:	int			ca;
;1956:
;1957:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $929
line 1958
;1958:		return;
ADDRGP4 $928
JUMPV
LABELV $929
line 1961
;1959:	}
;1960:
;1961:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $932
line 1962
;1962:		return;
ADDRGP4 $928
JUMPV
LABELV $932
line 1965
;1963:	}
;1964:
;1965:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+111732
INDIRI4
CNSTI4 0
EQI4 $935
line 1966
;1966:		return;
ADDRGP4 $928
JUMPV
LABELV $935
line 1970
;1967:	}
;1968:
;1969:	// set color based on health
;1970:	if ( cg_crosshairHealth.integer ) {
ADDRGP4 cg_crosshairHealth+12
INDIRI4
CNSTI4 0
EQI4 $938
line 1973
;1971:		vec4_t		hcolor;
;1972:
;1973:		CG_ColorForHealth( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 1974
;1974:		trap_R_SetColor( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1975
;1975:	} else {
ADDRGP4 $939
JUMPV
LABELV $938
line 1976
;1976:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1977
;1977:	}
LABELV $939
line 1979
;1978:
;1979:	w = h = cg_crosshairSize.value;
ADDRLP4 28
ADDRGP4 cg_crosshairSize+8
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRF4
ASGNF4
line 1982
;1980:
;1981:	// pulse the size of the crosshair when picking up items
;1982:	f = cg.time - cg.itemPickupBlendTime;
ADDRLP4 8
ADDRGP4 cg+111708
INDIRI4
ADDRGP4 cg+128788
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 1983
;1983:	if ( f > 0 && f < ITEM_BLOB_TIME ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $944
ADDRLP4 8
INDIRF4
CNSTF4 1128792064
GEF4 $944
line 1984
;1984:		f /= ITEM_BLOB_TIME;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 1985
;1985:		w *= ( 1 + f );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 1986
;1986:		h *= ( 1 + f );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 1987
;1987:	}
LABELV $944
line 1989
;1988:
;1989:	x = cg_crosshairX.integer;
ADDRLP4 16
ADDRGP4 cg_crosshairX+12
INDIRI4
CVIF4 4
ASGNF4
line 1990
;1990:	y = cg_crosshairY.integer;
ADDRLP4 20
ADDRGP4 cg_crosshairY+12
INDIRI4
CVIF4 4
ASGNF4
line 1991
;1991:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 1993
;1992:
;1993:	ca = cg_drawCrosshair.integer;
ADDRLP4 12
ADDRGP4 cg_drawCrosshair+12
INDIRI4
ASGNI4
line 1994
;1994:	if (ca < 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $949
line 1995
;1995:		ca = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1996
;1996:	}
LABELV $949
line 1997
;1997:	hShader = cgs.media.crosshairShader[ ca % NUM_CROSSHAIRS ];
ADDRLP4 24
ADDRLP4 12
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+224
ADDP4
INDIRI4
ASGNI4
line 1999
;1998:
;1999:	trap_R_DrawStretchPic( x + cg.refdef.x + 0.5 * (cg.refdef.width - w), 
ADDRLP4 36
CNSTF4 1056964608
ASGNF4
ADDRLP4 40
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRGP4 cg+113160
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 36
INDIRF4
ADDRGP4 cg+113160+8
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 44
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRGP4 cg+113160+4
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 36
INDIRF4
ADDRGP4 cg+113160+12
INDIRI4
CVIF4 4
ADDRLP4 44
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
CNSTF4 1065353216
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2002
;2000:		y + cg.refdef.y + 0.5 * (cg.refdef.height - h), 
;2001:		w, h, 0, 0, 1, 1, hShader );
;2002:}
LABELV $928
endproc CG_DrawCrosshair 56 36
proc CG_ScanForCrosshairEntity 96 28
line 2011
;2003:
;2004:
;2005:
;2006:/*
;2007:=================
;2008:CG_ScanForCrosshairEntity
;2009:=================
;2010:*/
;2011:static void CG_ScanForCrosshairEntity( void ) {
line 2016
;2012:	trace_t		trace;
;2013:	vec3_t		start, end;
;2014:	int			content;
;2015:
;2016:	VectorCopy( cg.refdef.vieworg, start );
ADDRLP4 56
ADDRGP4 cg+113160+24
INDIRB
ASGNB 12
line 2017
;2017:	VectorMA( start, 131072, cg.refdef.viewaxis[0], end );
ADDRLP4 84
CNSTF4 1207959552
ASGNF4
ADDRLP4 68
ADDRLP4 56
INDIRF4
ADDRLP4 84
INDIRF4
ADDRGP4 cg+113160+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 56+4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRGP4 cg+113160+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 56+8
INDIRF4
CNSTF4 1207959552
ADDRGP4 cg+113160+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2019
;2018:
;2019:	CG_Trace( &trace, start, vec3_origin, vec3_origin, end, 
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 88
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 33554433
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 2021
;2020:		cg.snap->ps.clientNum, CONTENTS_SOLID|CONTENTS_BODY );
;2021:	if ( trace.entityNum >= MAX_CLIENTS ) {
ADDRLP4 0+52
INDIRI4
CNSTI4 64
LTI4 $976
line 2022
;2022:		return;
ADDRGP4 $960
JUMPV
LABELV $976
line 2026
;2023:	}
;2024:
;2025:	// if the player is in fog, don't show it
;2026:	content = trap_CM_PointContents( trace.endpos, 0 );
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 92
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 92
INDIRI4
ASGNI4
line 2027
;2027:	if ( content & CONTENTS_FOG ) {
ADDRLP4 80
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $980
line 2028
;2028:		return;
ADDRGP4 $960
JUMPV
LABELV $980
line 2032
;2029:	}
;2030:
;2031:	// if the player is invisible, don't show it
;2032:	if ( cg_entities[ trace.entityNum ].currentState.powerups & ( 1 << PW_INVIS ) ) {
CNSTI4 740
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 cg_entities+188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $982
line 2033
;2033:		return;
ADDRGP4 $960
JUMPV
LABELV $982
line 2037
;2034:	}
;2035:
;2036:	// update the fade timer
;2037:	cg.crosshairClientNum = trace.entityNum;
ADDRGP4 cg+128516
ADDRLP4 0+52
INDIRI4
ASGNI4
line 2038
;2038:	cg.crosshairClientTime = cg.time;
ADDRGP4 cg+128520
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 2039
;2039:}
LABELV $960
endproc CG_ScanForCrosshairEntity 96 28
proc CG_DrawCrosshairNames 20 16
line 2047
;2040:
;2041:
;2042:/*
;2043:=====================
;2044:CG_DrawCrosshairNames
;2045:=====================
;2046:*/
;2047:static void CG_DrawCrosshairNames( void ) {
line 2052
;2048:	float		*color;
;2049:	char		*name;
;2050:	float		w;
;2051:
;2052:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $991
line 2053
;2053:		return;
ADDRGP4 $990
JUMPV
LABELV $991
line 2055
;2054:	}
;2055:	if ( !cg_drawCrosshairNames.integer ) {
ADDRGP4 cg_drawCrosshairNames+12
INDIRI4
CNSTI4 0
NEI4 $994
line 2056
;2056:		return;
ADDRGP4 $990
JUMPV
LABELV $994
line 2058
;2057:	}
;2058:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+111732
INDIRI4
CNSTI4 0
EQI4 $997
line 2059
;2059:		return;
ADDRGP4 $990
JUMPV
LABELV $997
line 2063
;2060:	}
;2061:
;2062:	// scan the known entities to see if the crosshair is sighted on one
;2063:	CG_ScanForCrosshairEntity();
ADDRGP4 CG_ScanForCrosshairEntity
CALLV
pop
line 2066
;2064:
;2065:	// draw the name of the player being looked at
;2066:	color = CG_FadeColor( cg.crosshairClientTime, 1000 );
ADDRGP4 cg+128520
INDIRI4
ARGI4
CNSTI4 1000
ARGI4
ADDRLP4 12
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 2067
;2067:	if ( !color ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1001
line 2068
;2068:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2069
;2069:		return;
ADDRGP4 $990
JUMPV
LABELV $1001
line 2072
;2070:	}
;2071:
;2072:	name = cgs.clientinfo[ cg.crosshairClientNum ].name;
ADDRLP4 4
CNSTI4 1708
ADDRGP4 cg+128516
INDIRI4
MULI4
ADDRGP4 cgs+40972+4
ADDP4
ASGNP4
line 2078
;2073:#ifdef MISSIONPACK
;2074:	color[3] *= 0.5f;
;2075:	w = CG_Text_Width(name, 0.3f, 0);
;2076:	CG_Text_Paint( 320 - w / 2, 190, 0.3f, color, name, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
;2077:#else
;2078:	w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
CVIF4 4
ASGNF4
line 2079
;2079:	CG_DrawBigString( 320 - w / 2, 170, name, color[3] * 0.5f );
CNSTF4 1134559232
ADDRLP4 8
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
CVFI4 4
ARGI4
CNSTI4 170
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2081
;2080:#endif
;2081:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2082
;2082:}
LABELV $990
endproc CG_DrawCrosshairNames 20 16
proc CG_DrawSpectator 0 16
line 2092
;2083:
;2084:
;2085://==============================================================================
;2086:
;2087:/*
;2088:=================
;2089:CG_DrawSpectator
;2090:=================
;2091:*/
;2092:static void CG_DrawSpectator(void) {
line 2093
;2093:	CG_DrawBigString(320 - 9 * 8, 440, "SPECTATOR", 1.0F);
CNSTI4 248
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $1007
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2094
;2094:	if ( cgs.gametype == GT_TOURNAMENT ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $1008
line 2095
;2095:		CG_DrawBigString(320 - 15 * 8, 460, "waiting to play", 1.0F);
CNSTI4 200
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $1011
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2096
;2096:	}
ADDRGP4 $1009
JUMPV
LABELV $1008
line 2097
;2097:	else if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1012
line 2098
;2098:		CG_DrawBigString(320 - 39 * 8, 460, "press ESC and use the JOIN menu to play", 1.0F);
CNSTI4 8
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $1015
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2099
;2099:	}
LABELV $1012
LABELV $1009
line 2100
;2100:}
LABELV $1006
endproc CG_DrawSpectator 0 16
proc CG_DrawVote 12 20
line 2107
;2101:
;2102:/*
;2103:=================
;2104:CG_DrawVote
;2105:=================
;2106:*/
;2107:static void CG_DrawVote(void) {
line 2111
;2108:	char	*s;
;2109:	int		sec;
;2110:
;2111:	if ( !cgs.voteTime ) {
ADDRGP4 cgs+31676
INDIRI4
CNSTI4 0
NEI4 $1017
line 2112
;2112:		return;
ADDRGP4 $1016
JUMPV
LABELV $1017
line 2116
;2113:	}
;2114:
;2115:	// play a talk beep whenever it is modified
;2116:	if ( cgs.voteModified ) {
ADDRGP4 cgs+31688
INDIRI4
CNSTI4 0
EQI4 $1020
line 2117
;2117:		cgs.voteModified = qfalse;
ADDRGP4 cgs+31688
CNSTI4 0
ASGNI4
line 2118
;2118:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+152340+780
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2119
;2119:	}
LABELV $1020
line 2121
;2120:
;2121:	sec = ( VOTE_TIME - ( cg.time - cgs.voteTime ) ) / 1000;
ADDRLP4 0
CNSTI4 30000
ADDRGP4 cg+111708
INDIRI4
ADDRGP4 cgs+31676
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2122
;2122:	if ( sec < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1028
line 2123
;2123:		sec = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2124
;2124:	}
LABELV $1028
line 2131
;2125:#ifdef MISSIONPACK
;2126:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);
;2127:	CG_DrawSmallString( 0, 58, s, 1.0F );
;2128:	s = "or press ESC then click Vote";
;2129:	CG_DrawSmallString( 0, 58 + SMALLCHAR_HEIGHT + 2, s, 1.0F );
;2130:#else
;2131:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo );
ADDRGP4 $1030
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cgs+31692
ARGP4
ADDRGP4 cgs+31680
INDIRI4
ARGI4
ADDRGP4 cgs+31684
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 2132
;2132:	CG_DrawSmallString( 0, 58, s, 1.0F );
CNSTI4 0
ARGI4
CNSTI4 58
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 2134
;2133:#endif
;2134:}
LABELV $1016
endproc CG_DrawVote 12 20
proc CG_DrawTeamVote 24 20
line 2141
;2135:
;2136:/*
;2137:=================
;2138:CG_DrawTeamVote
;2139:=================
;2140:*/
;2141:static void CG_DrawTeamVote(void) {
line 2145
;2142:	char	*s;
;2143:	int		sec, cs_offset;
;2144:
;2145:	if ( cgs.clientinfo->team == TEAM_RED )
ADDRGP4 cgs+40972+68
INDIRI4
CNSTI4 1
NEI4 $1035
line 2146
;2146:		cs_offset = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1036
JUMPV
LABELV $1035
line 2147
;2147:	else if ( cgs.clientinfo->team == TEAM_BLUE )
ADDRGP4 cgs+40972+68
INDIRI4
CNSTI4 2
NEI4 $1034
line 2148
;2148:		cs_offset = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2150
;2149:	else
;2150:		return;
LABELV $1040
LABELV $1036
line 2152
;2151:
;2152:	if ( !cgs.teamVoteTime[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32716
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1043
line 2153
;2153:		return;
ADDRGP4 $1034
JUMPV
LABELV $1043
line 2157
;2154:	}
;2155:
;2156:	// play a talk beep whenever it is modified
;2157:	if ( cgs.teamVoteModified[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1046
line 2158
;2158:		cgs.teamVoteModified[cs_offset] = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32740
ADDP4
CNSTI4 0
ASGNI4
line 2159
;2159:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+152340+780
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2160
;2160:	}
LABELV $1046
line 2162
;2161:
;2162:	sec = ( VOTE_TIME - ( cg.time - cgs.teamVoteTime[cs_offset] ) ) / 1000;
ADDRLP4 4
CNSTI4 30000
ADDRGP4 cg+111708
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32716
ADDP4
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2163
;2163:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1054
line 2164
;2164:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2165
;2165:	}
LABELV $1054
line 2166
;2166:	s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
ADDRGP4 $1056
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+32748
ADDP4
ARGP4
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 cgs+32724
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ADDRGP4 cgs+32732
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 2168
;2167:							cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
;2168:	CG_DrawSmallString( 0, 90, s, 1.0F );
CNSTI4 0
ARGI4
CNSTI4 90
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 2169
;2169:}
LABELV $1034
endproc CG_DrawTeamVote 24 20
proc CG_DrawScoreboard 4 0
line 2172
;2170:
;2171:
;2172:static qboolean CG_DrawScoreboard() {
line 2237
;2173:#ifdef MISSIONPACK
;2174:	static qboolean firstTime = qtrue;
;2175:	float fade, *fadeColor;
;2176:
;2177:	if (menuScoreboard) {
;2178:		menuScoreboard->window.flags &= ~WINDOW_FORCED;
;2179:	}
;2180:	if (cg_paused.integer) {
;2181:		cg.deferredPlayerLoading = 0;
;2182:		firstTime = qtrue;
;2183:		return qfalse;
;2184:	}
;2185:
;2186:	// should never happen in Team Arena
;2187:	if (cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;2188:		cg.deferredPlayerLoading = 0;
;2189:		firstTime = qtrue;
;2190:		return qfalse;
;2191:	}
;2192:
;2193:	// don't draw scoreboard during death while warmup up
;2194:	if ( cg.warmup && !cg.showScores ) {
;2195:		return qfalse;
;2196:	}
;2197:
;2198:	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD || cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;2199:		fade = 1.0;
;2200:		fadeColor = colorWhite;
;2201:	} else {
;2202:		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );
;2203:		if ( !fadeColor ) {
;2204:			// next time scoreboard comes up, don't print killer
;2205:			cg.deferredPlayerLoading = 0;
;2206:			cg.killerName[0] = 0;
;2207:			firstTime = qtrue;
;2208:			return qfalse;
;2209:		}
;2210:		fade = *fadeColor;
;2211:	}																					  
;2212:
;2213:
;2214:	if (menuScoreboard == NULL) {
;2215:		if ( cgs.gametype >= GT_TEAM ) {
;2216:			menuScoreboard = Menus_FindByName("teamscore_menu");
;2217:		} else {
;2218:			menuScoreboard = Menus_FindByName("score_menu");
;2219:		}
;2220:	}
;2221:
;2222:	if (menuScoreboard) {
;2223:		if (firstTime) {
;2224:			CG_SetScoreSelection(menuScoreboard);
;2225:			firstTime = qfalse;
;2226:		}
;2227:		Menu_Paint(menuScoreboard, qtrue);
;2228:	}
;2229:
;2230:	// load any models that have been deferred
;2231:	if ( ++cg.deferredPlayerLoading > 10 ) {
;2232:		CG_LoadDeferredPlayers();
;2233:	}
;2234:
;2235:	return qtrue;
;2236:#else
;2237:	return CG_DrawOldScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawOldScoreboard
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $1060
endproc CG_DrawScoreboard 4 0
proc CG_DrawIntermission 4 0
line 2246
;2238:#endif
;2239:}
;2240:
;2241:/*
;2242:=================
;2243:CG_DrawIntermission
;2244:=================
;2245:*/
;2246:static void CG_DrawIntermission( void ) {
line 2254
;2247://	int key;
;2248:#ifdef MISSIONPACK
;2249:	//if (cg_singlePlayer.integer) {
;2250:	//	CG_DrawCenterString();
;2251:	//	return;
;2252:	//}
;2253:#else
;2254:	if ( cgs.gametype == GT_SINGLE_PLAYER ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 2
NEI4 $1062
line 2255
;2255:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 2256
;2256:		return;
ADDRGP4 $1061
JUMPV
LABELV $1062
line 2259
;2257:	}
;2258:#endif
;2259:	cg.scoreFadeTime = cg.time;
ADDRGP4 cg+118444
ADDRGP4 cg+111708
INDIRI4
ASGNI4
line 2260
;2260:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+118440
ADDRLP4 0
INDIRI4
ASGNI4
line 2261
;2261:}
LABELV $1061
endproc CG_DrawIntermission 4 0
proc CG_DrawFollow 32 36
line 2268
;2262:
;2263:/*
;2264:=================
;2265:CG_DrawFollow
;2266:=================
;2267:*/
;2268:static qboolean CG_DrawFollow( void ) {
line 2273
;2269:	float		x;
;2270:	vec4_t		color;
;2271:	const char	*name;
;2272:
;2273:	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $1069
line 2274
;2274:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1068
JUMPV
LABELV $1069
line 2276
;2275:	}
;2276:	color[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 2277
;2277:	color[1] = 1;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 2278
;2278:	color[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 2279
;2279:	color[3] = 1;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 2282
;2280:
;2281:
;2282:	CG_DrawBigString( 320 - 9 * 8, 24, "following", 1.0F );
CNSTI4 248
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 $1075
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2284
;2283:
;2284:	name = cgs.clientinfo[ cg.snap->ps.clientNum ].name;
ADDRLP4 16
CNSTI4 1708
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40972+4
ADDP4
ASGNP4
line 2286
;2285:
;2286:	x = 0.5 * ( 640 - GIANT_WIDTH * CG_DrawStrlen( name ) );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
CNSTF4 1056964608
CNSTI4 640
ADDRLP4 24
INDIRI4
CNSTI4 5
LSHI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 2288
;2287:
;2288:	CG_DrawStringExt( x, 40, name, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );
ADDRLP4 20
INDIRF4
CVFI4 4
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2290
;2289:
;2290:	return qtrue;
CNSTI4 1
RETI4
LABELV $1068
endproc CG_DrawFollow 32 36
proc CG_DrawAmmoWarning 12 16
line 2300
;2291:}
;2292:
;2293:
;2294:
;2295:/*
;2296:=================
;2297:CG_DrawAmmoWarning
;2298:=================
;2299:*/
;2300:static void CG_DrawAmmoWarning( void ) {
line 2304
;2301:	const char	*s;
;2302:	int			w;
;2303:
;2304:	if ( cg_drawAmmoWarning.integer == 0 ) {
ADDRGP4 cg_drawAmmoWarning+12
INDIRI4
CNSTI4 0
NEI4 $1080
line 2305
;2305:		return;
ADDRGP4 $1079
JUMPV
LABELV $1080
line 2308
;2306:	}
;2307:
;2308:	if ( !cg.lowAmmoWarning ) {
ADDRGP4 cg+128508
INDIRI4
CNSTI4 0
NEI4 $1083
line 2309
;2309:		return;
ADDRGP4 $1079
JUMPV
LABELV $1083
line 2312
;2310:	}
;2311:
;2312:	if ( cg.lowAmmoWarning == 2 ) {
ADDRGP4 cg+128508
INDIRI4
CNSTI4 2
NEI4 $1086
line 2313
;2313:		s = "OUT OF AMMO";
ADDRLP4 0
ADDRGP4 $1089
ASGNP4
line 2314
;2314:	} else {
ADDRGP4 $1087
JUMPV
LABELV $1086
line 2315
;2315:		s = "LOW AMMO WARNING";
ADDRLP4 0
ADDRGP4 $1090
ASGNP4
line 2316
;2316:	}
LABELV $1087
line 2317
;2317:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2318
;2318:	CG_DrawBigString(320 - w / 2, 64, s, 1.0F);
CNSTI4 320
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2319
;2319:}
LABELV $1079
endproc CG_DrawAmmoWarning 12 16
proc CG_DrawWarmup 56 36
line 2368
;2320:
;2321:
;2322:#ifdef MISSIONPACK
;2323:/*
;2324:=================
;2325:CG_DrawProxWarning
;2326:=================
;2327:*/
;2328:static void CG_DrawProxWarning( void ) {
;2329:	char s [32];
;2330:	int			w;
;2331:  static int proxTime;
;2332:  static int proxCounter;
;2333:  static int proxTick;
;2334:
;2335:	if( !(cg.snap->ps.eFlags & EF_TICKING ) ) {
;2336:    proxTime = 0;
;2337:		return;
;2338:	}
;2339:
;2340:  if (proxTime == 0) {
;2341:    proxTime = cg.time + 5000;
;2342:    proxCounter = 5;
;2343:    proxTick = 0;
;2344:  }
;2345:
;2346:  if (cg.time > proxTime) {
;2347:    proxTick = proxCounter--;
;2348:    proxTime = cg.time + 1000;
;2349:  }
;2350:
;2351:  if (proxTick != 0) {
;2352:    Com_sprintf(s, sizeof(s), "INTERNAL COMBUSTION IN: %i", proxTick);
;2353:  } else {
;2354:    Com_sprintf(s, sizeof(s), "YOU HAVE BEEN MINED");
;2355:  }
;2356:
;2357:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
;2358:	CG_DrawBigStringColor( 320 - w / 2, 64 + BIGCHAR_HEIGHT, s, g_color_table[ColorIndex(COLOR_RED)] );
;2359:}
;2360:#endif
;2361:
;2362:
;2363:/*
;2364:=================
;2365:CG_DrawWarmup
;2366:=================
;2367:*/
;2368:static void CG_DrawWarmup( void ) {
line 2377
;2369:	int			w;
;2370:	int			sec;
;2371:	int			i;
;2372:	float scale;
;2373:	clientInfo_t	*ci1, *ci2;
;2374:	int			cw;
;2375:	const char	*s;
;2376:
;2377:	sec = cg.warmup;
ADDRLP4 4
ADDRGP4 cg+128772
INDIRI4
ASGNI4
line 2378
;2378:	if ( !sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1093
line 2379
;2379:		return;
ADDRGP4 $1091
JUMPV
LABELV $1093
line 2382
;2380:	}
;2381:
;2382:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1095
line 2383
;2383:		s = "Waiting for players";		
ADDRLP4 8
ADDRGP4 $1097
ASGNP4
line 2384
;2384:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2385
;2385:		CG_DrawBigString(320 - w / 2, 24, s, 1.0F);
CNSTI4 320
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 24
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2386
;2386:		cg.warmupCount = 0;
ADDRGP4 cg+128776
CNSTI4 0
ASGNI4
line 2387
;2387:		return;
ADDRGP4 $1091
JUMPV
LABELV $1095
line 2390
;2388:	}
;2389:
;2390:	if (cgs.gametype == GT_TOURNAMENT) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $1099
line 2392
;2391:		// find the two active players
;2392:		ci1 = NULL;
ADDRLP4 20
CNSTP4 0
ASGNP4
line 2393
;2393:		ci2 = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 2394
;2394:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1105
JUMPV
LABELV $1102
line 2395
;2395:			if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE ) {
ADDRLP4 32
CNSTI4 1708
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+40972
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $1107
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1107
line 2396
;2396:				if ( !ci1 ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1112
line 2397
;2397:					ci1 = &cgs.clientinfo[i];
ADDRLP4 20
CNSTI4 1708
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 2398
;2398:				} else {
ADDRGP4 $1113
JUMPV
LABELV $1112
line 2399
;2399:					ci2 = &cgs.clientinfo[i];
ADDRLP4 24
CNSTI4 1708
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 2400
;2400:				}
LABELV $1113
line 2401
;2401:			}
LABELV $1107
line 2402
;2402:		}
LABELV $1103
line 2394
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1105
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $1102
line 2404
;2403:
;2404:		if ( ci1 && ci2 ) {
ADDRLP4 32
CNSTU4 0
ASGNU4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1100
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1100
line 2405
;2405:			s = va( "%s vs %s", ci1->name, ci2->name );
ADDRGP4 $1118
ARGP4
ADDRLP4 36
CNSTI4 4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
ASGNP4
line 2410
;2406:#ifdef MISSIONPACK
;2407:			w = CG_Text_Width(s, 0.6f, 0);
;2408:			CG_Text_Paint(320 - w / 2, 60, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2409:#else
;2410:			w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 44
INDIRI4
ASGNI4
line 2411
;2411:			if ( w > 640 / GIANT_WIDTH ) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $1119
line 2412
;2412:				cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 2413
;2413:			} else {
ADDRGP4 $1120
JUMPV
LABELV $1119
line 2414
;2414:				cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 2415
;2415:			}
LABELV $1120
line 2416
;2416:			CG_DrawStringExt( 320 - w * cw/2, 20,s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 20
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2419
;2417:					qfalse, qtrue, cw, (int)(cw * 1.5f), 0 );
;2418:#endif
;2419:		}
line 2420
;2420:	} else {
ADDRGP4 $1100
JUMPV
LABELV $1099
line 2421
;2421:		if ( cgs.gametype == GT_FFA ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 0
NEI4 $1121
line 2422
;2422:			s = "Free For All";
ADDRLP4 8
ADDRGP4 $1124
ASGNP4
line 2423
;2423:		} else if ( cgs.gametype == GT_TEAM ) {
ADDRGP4 $1122
JUMPV
LABELV $1121
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
NEI4 $1125
line 2424
;2424:			s = "Team Deathmatch";
ADDRLP4 8
ADDRGP4 $1128
ASGNP4
line 2425
;2425:		} else if ( cgs.gametype == GT_CTF ) {
ADDRGP4 $1126
JUMPV
LABELV $1125
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $1129
line 2426
;2426:			s = "Capture the Flag";
ADDRLP4 8
ADDRGP4 $1132
ASGNP4
line 2435
;2427:#ifdef MISSIONPACK
;2428:		} else if ( cgs.gametype == GT_1FCTF ) {
;2429:			s = "One Flag CTF";
;2430:		} else if ( cgs.gametype == GT_OBELISK ) {
;2431:			s = "Overload";
;2432:		} else if ( cgs.gametype == GT_HARVESTER ) {
;2433:			s = "Harvester";
;2434:#endif
;2435:		} else {
ADDRGP4 $1130
JUMPV
LABELV $1129
line 2436
;2436:			s = "";
ADDRLP4 8
ADDRGP4 $1133
ASGNP4
line 2437
;2437:		}
LABELV $1130
LABELV $1126
LABELV $1122
line 2442
;2438:#ifdef MISSIONPACK
;2439:		w = CG_Text_Width(s, 0.6f, 0);
;2440:		CG_Text_Paint(320 - w / 2, 90, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2441:#else
;2442:		w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
line 2443
;2443:		if ( w > 640 / GIANT_WIDTH ) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $1134
line 2444
;2444:			cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 2445
;2445:		} else {
ADDRGP4 $1135
JUMPV
LABELV $1134
line 2446
;2446:			cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 2447
;2447:		}
LABELV $1135
line 2448
;2448:		CG_DrawStringExt( 320 - w * cw/2, 25,s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 25
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1066192077
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2451
;2449:				qfalse, qtrue, cw, (int)(cw * 1.1f), 0 );
;2450:#endif
;2451:	}
LABELV $1100
line 2453
;2452:
;2453:	sec = ( sec - cg.time ) / 1000;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRGP4 cg+111708
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2454
;2454:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1137
line 2455
;2455:		cg.warmup = 0;
ADDRGP4 cg+128772
CNSTI4 0
ASGNI4
line 2456
;2456:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2457
;2457:	}
LABELV $1137
line 2458
;2458:	s = va( "Starts in: %i", sec + 1 );
ADDRGP4 $1140
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 2459
;2459:	if ( sec != cg.warmupCount ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+128776
INDIRI4
EQI4 $1141
line 2460
;2460:		cg.warmupCount = sec;
ADDRGP4 cg+128776
ADDRLP4 4
INDIRI4
ASGNI4
line 2461
;2461:		switch ( sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1147
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $1150
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $1153
ADDRGP4 $1146
JUMPV
LABELV $1147
line 2463
;2462:		case 0:
;2463:			trap_S_StartLocalSound( cgs.media.count1Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+152340+1024
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2464
;2464:			break;
ADDRGP4 $1146
JUMPV
LABELV $1150
line 2466
;2465:		case 1:
;2466:			trap_S_StartLocalSound( cgs.media.count2Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+152340+1020
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2467
;2467:			break;
ADDRGP4 $1146
JUMPV
LABELV $1153
line 2469
;2468:		case 2:
;2469:			trap_S_StartLocalSound( cgs.media.count3Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+152340+1016
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2470
;2470:			break;
line 2472
;2471:		default:
;2472:			break;
LABELV $1146
line 2474
;2473:		}
;2474:	}
LABELV $1141
line 2475
;2475:	scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 2476
;2476:	switch ( cg.warmupCount ) {
ADDRLP4 36
ADDRGP4 cg+128776
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1159
ADDRLP4 36
INDIRI4
CNSTI4 1
EQI4 $1160
ADDRLP4 36
INDIRI4
CNSTI4 2
EQI4 $1161
ADDRGP4 $1156
JUMPV
LABELV $1159
line 2478
;2477:	case 0:
;2478:		cw = 28;
ADDRLP4 12
CNSTI4 28
ASGNI4
line 2479
;2479:		scale = 0.54f;
ADDRLP4 28
CNSTF4 1057635697
ASGNF4
line 2480
;2480:		break;
ADDRGP4 $1157
JUMPV
LABELV $1160
line 2482
;2481:	case 1:
;2482:		cw = 24;
ADDRLP4 12
CNSTI4 24
ASGNI4
line 2483
;2483:		scale = 0.51f;
ADDRLP4 28
CNSTF4 1057132380
ASGNF4
line 2484
;2484:		break;
ADDRGP4 $1157
JUMPV
LABELV $1161
line 2486
;2485:	case 2:
;2486:		cw = 20;
ADDRLP4 12
CNSTI4 20
ASGNI4
line 2487
;2487:		scale = 0.48f;
ADDRLP4 28
CNSTF4 1056293519
ASGNF4
line 2488
;2488:		break;
ADDRGP4 $1157
JUMPV
LABELV $1156
line 2490
;2489:	default:
;2490:		cw = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
line 2491
;2491:		scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 2492
;2492:		break;
LABELV $1157
line 2499
;2493:	}
;2494:
;2495:#ifdef MISSIONPACK
;2496:		w = CG_Text_Width(s, scale, 0);
;2497:		CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2498:#else
;2499:	w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 40
INDIRI4
ASGNI4
line 2500
;2500:	CG_DrawStringExt( 320 - w * cw/2, 70, s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 70
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2503
;2501:			qfalse, qtrue, cw, (int)(cw * 1.5), 0 );
;2502:#endif
;2503:}
LABELV $1091
endproc CG_DrawWarmup 56 36
proc CG_Draw2D 8 0
line 2528
;2504:
;2505://==================================================================================
;2506:#ifdef MISSIONPACK
;2507:/* 
;2508:=================
;2509:CG_DrawTimedMenus
;2510:=================
;2511:*/
;2512:void CG_DrawTimedMenus() {
;2513:	if (cg.voiceTime) {
;2514:		int t = cg.time - cg.voiceTime;
;2515:		if ( t > 2500 ) {
;2516:			Menus_CloseByName("voiceMenu");
;2517:			trap_Cvar_Set("cl_conXOffset", "0");
;2518:			cg.voiceTime = 0;
;2519:		}
;2520:	}
;2521:}
;2522:#endif
;2523:/*
;2524:=================
;2525:CG_Draw2D
;2526:=================
;2527:*/
;2528:static void CG_Draw2D( void ) {
line 2535
;2529:#ifdef MISSIONPACK
;2530:	if (cgs.orderPending && cg.time > cgs.orderTime) {
;2531:		CG_CheckOrderPending();
;2532:	}
;2533:#endif
;2534:	// if we are taking a levelshot for the menu, don't draw anything
;2535:	if ( cg.levelShot ) {
ADDRGP4 cg+12
INDIRI4
CNSTI4 0
EQI4 $1163
line 2536
;2536:		return;
ADDRGP4 $1162
JUMPV
LABELV $1163
line 2539
;2537:	}
;2538:
;2539:	if ( cg_draw2D.integer == 0 ) {
ADDRGP4 cg_draw2D+12
INDIRI4
CNSTI4 0
NEI4 $1166
line 2540
;2540:		return;
ADDRGP4 $1162
JUMPV
LABELV $1166
line 2543
;2541:	}
;2542:
;2543:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1169
line 2544
;2544:		CG_DrawIntermission();
ADDRGP4 CG_DrawIntermission
CALLV
pop
line 2545
;2545:		return;
ADDRGP4 $1162
JUMPV
LABELV $1169
line 2553
;2546:	}
;2547:
;2548:/*
;2549:	if (cg.cameraMode) {
;2550:		return;
;2551:	}
;2552:*/
;2553:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1172
line 2554
;2554:		CG_DrawSpectator();
ADDRGP4 CG_DrawSpectator
CALLV
pop
line 2555
;2555:		CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 2556
;2556:		CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 2557
;2557:	} else {
ADDRGP4 $1173
JUMPV
LABELV $1172
line 2559
;2558:		// don't draw any status if dead or the scoreboard is being explicitly shown
;2559:		if ( !cg.showScores && cg.snap->ps.stats[STAT_HEALTH] > 0 ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 cg+118436
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1175
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $1175
line 2567
;2560:
;2561:#ifdef MISSIONPACK
;2562:			if ( cg_drawStatus.integer ) {
;2563:				Menu_PaintAll();
;2564:				CG_DrawTimedMenus();
;2565:			}
;2566:#else
;2567:			CG_DrawStatusBar();
ADDRGP4 CG_DrawStatusBar
CALLV
pop
line 2570
;2568:#endif
;2569:      
;2570:			CG_DrawAmmoWarning();
ADDRGP4 CG_DrawAmmoWarning
CALLV
pop
line 2575
;2571:
;2572:#ifdef MISSIONPACK
;2573:			CG_DrawProxWarning();
;2574:#endif      
;2575:			CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 2576
;2576:			CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 2577
;2577:			CG_DrawWeaponSelect();
ADDRGP4 CG_DrawWeaponSelect
CALLV
pop
line 2580
;2578:
;2579:#ifndef MISSIONPACK
;2580:			CG_DrawHoldableItem();
ADDRGP4 CG_DrawHoldableItem
CALLV
pop
line 2584
;2581:#else
;2582:			//CG_DrawPersistantPowerup();
;2583:#endif
;2584:			CG_DrawReward();
ADDRGP4 CG_DrawReward
CALLV
pop
line 2585
;2585:		}
LABELV $1175
line 2587
;2586:    
;2587:		if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1179
line 2589
;2588:#ifndef MISSIONPACK
;2589:			CG_DrawTeamInfo();
ADDRGP4 CG_DrawTeamInfo
CALLV
pop
line 2591
;2590:#endif
;2591:		}
LABELV $1179
line 2592
;2592:	}
LABELV $1173
line 2594
;2593:
;2594:	CG_DrawVote();
ADDRGP4 CG_DrawVote
CALLV
pop
line 2595
;2595:	CG_DrawTeamVote();
ADDRGP4 CG_DrawTeamVote
CALLV
pop
line 2597
;2596:
;2597:	CG_DrawLagometer();
ADDRGP4 CG_DrawLagometer
CALLV
pop
line 2604
;2598:
;2599:#ifdef MISSIONPACK
;2600:	if (!cg_paused.integer) {
;2601:		CG_DrawUpperRight();
;2602:	}
;2603:#else
;2604:	CG_DrawUpperRight();
ADDRGP4 CG_DrawUpperRight
CALLV
pop
line 2608
;2605:#endif
;2606:
;2607:#ifndef MISSIONPACK
;2608:	CG_DrawLowerRight();
ADDRGP4 CG_DrawLowerRight
CALLV
pop
line 2609
;2609:	CG_DrawLowerLeft();
ADDRGP4 CG_DrawLowerLeft
CALLV
pop
line 2612
;2610:#endif
;2611:
;2612:	if ( !CG_DrawFollow() ) {
ADDRLP4 0
ADDRGP4 CG_DrawFollow
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1182
line 2613
;2613:		CG_DrawWarmup();
ADDRGP4 CG_DrawWarmup
CALLV
pop
line 2614
;2614:	}
LABELV $1182
line 2617
;2615:
;2616:	// don't draw center string if scoreboard is up
;2617:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 4
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+118440
ADDRLP4 4
INDIRI4
ASGNI4
line 2618
;2618:	if ( !cg.scoreBoardShowing) {
ADDRGP4 cg+118440
INDIRI4
CNSTI4 0
NEI4 $1185
line 2619
;2619:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 2620
;2620:	}
LABELV $1185
line 2621
;2621:}
LABELV $1162
endproc CG_Draw2D 8 0
proc CG_DrawTourneyScoreboard 0 0
line 2624
;2622:
;2623:
;2624:static void CG_DrawTourneyScoreboard() {
line 2627
;2625:#ifdef MISSIONPACK
;2626:#else
;2627:	CG_DrawOldTourneyScoreboard();
ADDRGP4 CG_DrawOldTourneyScoreboard
CALLV
pop
line 2629
;2628:#endif
;2629:}
LABELV $1188
endproc CG_DrawTourneyScoreboard 0 0
export CG_DrawActive
proc CG_DrawActive 24 4
line 2638
;2630:
;2631:/*
;2632:=====================
;2633:CG_DrawActive
;2634:
;2635:Perform all drawing needed to completely fill the screen
;2636:=====================
;2637:*/
;2638:void CG_DrawActive( stereoFrame_t stereoView ) {
line 2643
;2639:	float		separation;
;2640:	vec3_t		baseOrg;
;2641:
;2642:	// optionally draw the info screen instead
;2643:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1190
line 2644
;2644:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 2645
;2645:		return;
ADDRGP4 $1189
JUMPV
LABELV $1190
line 2649
;2646:	}
;2647:
;2648:	// optionally draw the tournement scoreboard instead
;2649:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1193
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1193
line 2650
;2650:		( cg.snap->ps.pm_flags & PMF_SCOREBOARD ) ) {
line 2651
;2651:		CG_DrawTourneyScoreboard();
ADDRGP4 CG_DrawTourneyScoreboard
CALLV
pop
line 2652
;2652:		return;
ADDRGP4 $1189
JUMPV
LABELV $1193
line 2655
;2653:	}
;2654:
;2655:	switch ( stereoView ) {
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1200
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $1201
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $1203
ADDRGP4 $1197
JUMPV
LABELV $1200
line 2657
;2656:	case STEREO_CENTER:
;2657:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2658
;2658:		break;
ADDRGP4 $1198
JUMPV
LABELV $1201
line 2660
;2659:	case STEREO_LEFT:
;2660:		separation = -cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
NEGF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2661
;2661:		break;
ADDRGP4 $1198
JUMPV
LABELV $1203
line 2663
;2662:	case STEREO_RIGHT:
;2663:		separation = cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2664
;2664:		break;
ADDRGP4 $1198
JUMPV
LABELV $1197
line 2666
;2665:	default:
;2666:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2667
;2667:		CG_Error( "CG_DrawActive: Undefined stereoView" );
ADDRGP4 $1205
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2668
;2668:	}
LABELV $1198
line 2672
;2669:
;2670:
;2671:	// clear around the rendered view if sized down
;2672:	CG_TileClear();
ADDRGP4 CG_TileClear
CALLV
pop
line 2675
;2673:
;2674:	// offset vieworg appropriately if we're doing stereo separation
;2675:	VectorCopy( cg.refdef.vieworg, baseOrg );
ADDRLP4 4
ADDRGP4 cg+113160+24
INDIRB
ASGNB 12
line 2676
;2676:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $1208
line 2677
;2677:		VectorMA( cg.refdef.vieworg, -separation, cg.refdef.viewaxis[1], cg.refdef.vieworg );
ADDRGP4 cg+113160+24
ADDRGP4 cg+113160+24
INDIRF4
ADDRGP4 cg+113160+36+12
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+113160+24+4
ADDRGP4 cg+113160+24+4
INDIRF4
ADDRGP4 cg+113160+36+12+4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+113160+24+8
ADDRGP4 cg+113160+24+8
INDIRF4
ADDRGP4 cg+113160+36+12+8
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 2678
;2678:	}
LABELV $1208
line 2681
;2679:
;2680:	// draw 3D view
;2681:	trap_R_RenderScene( &cg.refdef );
ADDRGP4 cg+113160
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 2684
;2682:
;2683:	// restore original viewpoint if running stereo
;2684:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $1238
line 2685
;2685:		VectorCopy( baseOrg, cg.refdef.vieworg );
ADDRGP4 cg+113160+24
ADDRLP4 4
INDIRB
ASGNB 12
line 2686
;2686:	}
LABELV $1238
line 2689
;2687:
;2688:	// draw status bar and other floating elements
;2689: 	CG_Draw2D();
ADDRGP4 CG_Draw2D
CALLV
pop
line 2690
;2690:}
LABELV $1189
endproc CG_DrawActive 24 4
bss
export lagometer
align 4
LABELV lagometer
skip 1544
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
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
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
export teamChat2
align 1
LABELV teamChat2
skip 256
export teamChat1
align 1
LABELV teamChat1
skip 256
export systemChat
align 1
LABELV systemChat
skip 256
export numSortedTeamPlayers
align 4
LABELV numSortedTeamPlayers
skip 4
export sortedTeamPlayers
align 4
LABELV sortedTeamPlayers
skip 128
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
LABELV $1205
byte 1 67
byte 1 71
byte 1 95
byte 1 68
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 58
byte 1 32
byte 1 85
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 111
byte 1 86
byte 1 105
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $1140
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1133
byte 1 0
align 1
LABELV $1132
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1128
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $1124
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1118
byte 1 37
byte 1 115
byte 1 32
byte 1 118
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1097
byte 1 87
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1090
byte 1 76
byte 1 79
byte 1 87
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 32
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $1089
byte 1 79
byte 1 85
byte 1 84
byte 1 32
byte 1 79
byte 1 70
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 0
align 1
LABELV $1075
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $1056
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1030
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1015
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 83
byte 1 67
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 74
byte 1 79
byte 1 73
byte 1 78
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1011
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1007
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 65
byte 1 84
byte 1 79
byte 1 82
byte 1 0
align 1
LABELV $881
byte 1 115
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $816
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 101
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $812
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 114
byte 1 117
byte 1 112
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $781
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $537
byte 1 37
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $492
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 0
align 1
LABELV $489
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $422
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $418
byte 1 37
byte 1 105
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $402
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $400
byte 1 110
byte 1 0
align 1
LABELV $341
byte 1 37
byte 1 105
byte 1 47
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $107
byte 1 37
byte 1 105
byte 1 0
