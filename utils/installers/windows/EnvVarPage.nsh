!include nsDialogs.nsh
!include LogicLib.nsh

Var Dialog
Var FirstTime

Var Label

Var CheckboxFAST_BUFFERS
Var CheckboxFAST_BUFFERS_State

Var CheckboxScripts
Var CheckboxScripts_State

Var CheckboxX64
Var CheckboxX64_State

Var CheckboxI86
Var CheckboxI86_State

LangString PAGE_TITLE ${LANG_ENGLISH} "Environment variables setting"
LangString PAGE_SUBTITLE ${LANG_ENGLISH} "Choose which environment variables you want to set."

Function VariablesEntornoPage

    !insertmacro MUI_HEADER_TEXT $(PAGE_TITLE) $(PAGE_SUBTITLE)

    nsDialogs::Create 1018
    
    Pop $Dialog

    ${If} $Dialog == error
        Abort
    ${EndIf}
       
    ### Creaci�n de los elementos gr�ficos    
    ${NSD_CreateLabel} 0 0 100% 20u "Check the environment variables you want to set and uncheck the environment variables you don't want to set. Click Next to continue."
    Pop $Label

    ${NSD_CreateCheckbox} 10 20u 100% 12u "Set the FAST_BUFFERS environment variable."
    Pop $CheckboxFAST_BUFFERS
    ${If} $CheckboxFAST_BUFFERS_State == ${BST_CHECKED}
        ${NSD_Check} $CheckboxFAST_BUFFERS
    ${EndIf}
        
    ${NSD_CreateCheckbox} 10 32u 100% 12u "&Add to the PATH environment variable the location of Fast Buffers scripts"
    Pop $CheckboxScripts
    ${If} $CheckboxScripts_State == ${BST_CHECKED}
        ${NSD_Check} $CheckboxScripts
    ${EndIf}
    
    ${If} ${RunningX64}
        ${NSD_CreateCheckbox} 10 44u 100% 24u "&Add to the PATH environment variable the location of Fast Buffers target libraries for platform x64"
        Pop $CheckboxX64  
        ${If} ${SectionIsSelected} ${SEC_LIB_x64}
            ${If} $CheckboxX64_State == ${BST_CHECKED}
                ${NSD_Check} $CheckboxX64
            ${EndIf}
        ${Else}
            ${NSD_AddStyle} $CheckboxX64 ${WS_DISABLED}
        ${EndIf}

        ### Fijamos los callbacks para cuando se haga click en los CheckBoxes
	${NSD_OnClick} $CheckboxX64 ClickX64  
    
        ${NSD_CreateCheckbox} 10 66u 100% 24u "&Add to the PATH environment variable the location of Fast Buffers target libraries for platform i86"
        Pop $CheckboxI86
    ${Else}
        ${NSD_CreateCheckbox} 10 44u 100% 24u "&Add to the PATH environment variable the location of Fast Buffers target libraries for platform i86"
        Pop $CheckboxI86
    ${EndIf}

    ${If} ${SectionIsSelected} ${SEC_LIB_i86}
        ${If} $CheckboxI86_State == ${BST_CHECKED}
            ${NSD_Check} $CheckboxI86
        ${EndIf}
    ${Else}
        ${NSD_AddStyle} $CheckboxI86 ${WS_DISABLED}
    ${EndIf}
    
    ### La primera vez que lanzamos el instalador, el checkbox de FAST_BUFFERS
    ### y el de SCRIPTS deben estar marcados. 
    StrCmp $FirstTime "FirstTime" +5 0 ### Si son iguales las cadenas, GOTO +5, si no, GOTO 0
        ${NSD_Check} $CheckboxFAST_BUFFERS
        ${NSD_Check} $CheckboxScripts
        ${NSD_GetState} $CheckboxFAST_BUFFERS $CheckboxFAST_BUFFERS_State
        ${NSD_GetState} $CheckboxScripts $CheckboxScripts_State
        StrCpy $FirstTime "FirstTime"
        
    ### Fijamos los callbacks para cuando se haga click en los CheckBoxes
    ${NSD_OnClick} $CheckboxFAST_BUFFERS ClickFAST_BUFFERS 
    ${NSD_OnClick} $CheckboxScripts ClickScripts
    ${NSD_OnClick} $CheckboxI86 ClickI86  

    nsDialogs::Show
FunctionEnd

### Callback invocado cuando se pulsa el CheckBox FAST_BUFFERS
### Guardamos el estado en la variable _state
Function ClickFAST_BUFFERS
    ${NSD_GetState} $CheckboxFAST_BUFFERS $CheckboxFAST_BUFFERS_State
FunctionEnd

### Callback invocado cuando se pulsa el CheckBox Scripts
### Guardamos el estado en la variable _state
Function ClickScripts
    ${NSD_GetState} $CheckboxScripts $CheckboxScripts_State
FunctionEnd

### Callback invocado cuando se pulsa el CheckBox x64
### Sirve para deshabilitar el i86, pues no pueden aparecer a la vez
### Tambi�n guardamos el estado en la variable _state
Function ClickX64
    Pop $CheckboxX64
    ${NSD_GetState} $CheckboxX64 $0
    ${If} $0 == 1
        ${NSD_SetState} $CheckboxI86 0
        ${NSD_GetState} $CheckboxI86 $CheckboxI86_State
    ${EndIf}
    ${NSD_GetState} $CheckboxX64 $CheckboxX64_State
FunctionEnd

### Callback invocado cuando se pulsa el CheckBox i86
### Sirve para deshabilitar el x64, pues no pueden aparecer a la vez
### Tambi�n guardamos el estado en la variable _state
Function ClickI86
    Pop $CheckboxI86
    ${NSD_GetState} $CheckboxI86 $0
    ${If} $0 == 1
        ${NSD_SetState} $CheckboxX64 0
        ${NSD_GetState} $CheckboxX64 $CheckboxX64_State
    ${EndIf}
    ${NSD_GetState} $CheckboxI86 $CheckboxI86_State
FunctionEnd
