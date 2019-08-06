
map <C-O> :call CreateCppObject()<CR>

function! CreateCppObject()

    let name_object = input("Enter name object: ")
    if strlen(name_object) == 0
        echo "Name object is required!"
        return v:false
    endif

    let name_file = input("Enter name file: ")
    if strlen(name_file) == 0
        let name_file = name_object
    endif

    let name_type_object = input("Enter type(0:class, 1:enum, 2:struct): ")
    if strlen(name_type_object) == 0
        let name_type_object = "0"
    endif


    " Get current path to dir from NERDTree
    let l:nerd_tree_pwd=g:NERDTree.ForCurrentTab().getRoot().path.str()

    if name_type_object == "0"
        call CreateCppClass(name_object, name_file, l:nerd_tree_pwd)
    elseif name_type_object == "1"
        call CreateCppEnum(name_object, name_file, l:nerd_tree_pwd)
    elseif name_type_object == "2"
        call CreateCppStruct(name_object, name_file, l:nerd_tree_pwd)
    endif

endfunction

function! CreateCppClass(name_class, name_file, location)

    " Create new file CPP
    exe "e! " . fnameescape(a:location . "/" . a:name_file . ".cpp")

    " Prepare text to file
    let l:text=""
	let l:text=l:text . "#include \"" . a:name_file . ".h\"\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "\n"
    let l:text=l:text . a:name_class . "::" . a:name_class . "()\n"
    let l:text=l:text . "{\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "}\n"
    let l:text=l:text . "\n"
    let l:text=l:text . a:name_class . "::~" . a:name_class . "()\n"
    let l:text=l:text . "{\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "}\n"
    let l:text=l:text . "\n"

    " Put text to file
    put! =l:text

   " Save new file on disk
    execute 'w'


    " Create new file H
    exe "e! " . fnameescape(a:location . "/" . a:name_file . ".h")

    " Prepare text to file
	let l:timestap=strftime('%d-%m-%Y %H:%M:%S')
    let l:text=""
	let l:text=l:text . "/*!\n"
    let l:text=l:text . "    \\author Jaroslaw Slabik\n"
    let l:text=l:text . "    \\date " . l:timestap . "\n"
    let l:text=l:text . "*/\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "#ifndef " . toupper(a:name_file) . "_H\n"
    let l:text=l:text . "#define " . toupper(a:name_file) . "_H\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "/*!\n"
    let l:text=l:text . "    \\class " . a:name_class . "\n"
    let l:text=l:text . "    \\brief A " . a:name_class . " class\n"
    let l:text=l:text . "*/\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "class " . a:name_class . "\n"
    let l:text=l:text . "{\n"
    let l:text=l:text . "    public:\n"
    let l:text=l:text . "        " . a:name_class . "();\n"
    let l:text=l:text . "        ~" . a:name_class . "();\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "    private:\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "};\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "#endif //" . toupper(a:name_file) . "_H\n"

    " Put text to file
    put! =l:text

    " Save new file on disk
    execute 'w'

    " Focus to NERDTree window
    execute 'NERDTreeFocus'

    " refresh NERDTree window to load new file on tab
    execute 'normal R'

endfunction

function! CreateCppStruct(name_struct, name_file, location)

    " Create new file H
    exe "e! " . fnameescape(a:location . "/" . a:name_file . ".h")

    " Prepare text to file
	let l:timestap=strftime('%d-%m-%Y %H:%M:%S')
    let l:text=""
	let l:text=l:text . "/*!\n"
    let l:text=l:text . "    \\author Jaroslaw Slabik\n"
    let l:text=l:text . "    \\date " . l:timestap . "\n"
    let l:text=l:text . "*/\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "#ifndef " . toupper(a:name_file) . "_H\n"
    let l:text=l:text . "#define " . toupper(a:name_file) . "_H\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "/*!\n"
    let l:text=l:text . "    \\struct " . a:name_struct . "\n"
    let l:text=l:text . "    \\brief A " . a:name_struct . " struct\n"
    let l:text=l:text . "*/\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "struct " . a:name_struct . "\n"
    let l:text=l:text . "{\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "};\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "#endif //" . toupper(a:name_file) . "_H\n"

    " Put text to file
    put! =l:text

    " Save new file on disk
    execute 'w'

    " Focus to NERDTree window
    execute 'NERDTreeFocus'

    " refresh NERDTree window to load new file on tab
    execute 'normal R'

endfunction

function! CreateCppEnum(name_enum, name_file, location)

    " Create new file H
    exe "e! " . fnameescape(a:location . "/" . a:name_file . ".h")

    " Prepare text to file
	let l:timestap=strftime('%d-%m-%Y %H:%M:%S')
    let l:text=""
	let l:text=l:text . "/*!\n"
    let l:text=l:text . "    \\author Jaroslaw Slabik\n"
    let l:text=l:text . "    \\date " . l:timestap . "\n"
    let l:text=l:text . "*/\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "#ifndef " . toupper(a:name_file) . "_H\n"
    let l:text=l:text . "#define " . toupper(a:name_file) . "_H\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "/*!\n"
    let l:text=l:text . "    \\enum " . a:name_enum . "\n"
    let l:text=l:text . "    \\brief A " . a:name_enum . " enum\n"
    let l:text=l:text . "*/\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "enum class " . a:name_enum . "\n"
    let l:text=l:text . "{\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "};\n"
    let l:text=l:text . "\n"
    let l:text=l:text . "#endif //" . toupper(a:name_file) . "_H\n"

    " Put text to file
    put! =l:text

    " Save new file on disk
    execute 'w'

    " Focus to NERDTree window
    execute 'NERDTreeFocus'

    " refresh NERDTree window to load new file on tab
    execute 'normal R'

endfunction

function! CreateMakefile(name_project, location)

    " Create makefile
    exe "e! " . fnameescape(a:location . "/Makefile")

    " Prepare text to file
    let l:text=""
    let l:text=l:text . "CC=g++\n"
    let l:text=l:text . "CFLAGS=-g -c -Wall\n"
    let l:text=l:text . "RM=/bin/rm -f\n"
    let l:text=l:text . "#for Windows, use RM=del\n\n"
    let l:text=l:text . "#start\n"
    let l:text=l:text . "__start__ : " . a:name_project . ".exe\n\n"

    let l:text=l:text . "#create the executable\n"
    let l:text=l:text . a:name_project . ".exe: main.o\n"
    let l:text=l:text . "\t${CC} main.o\n\n"

    let l:text=l:text . "#create the object file for main.cpp\n"
    let l:text=l:text . "main.o: main.cpp\n"
    let l:text=l:text . "\t${CC} ${CFLAGS} main.cpp\n\n"
    
    let l:text=l:text . "clean:\n"
    let l:text=l:text . "\t${RM} *.o " . a:name_project . ".exe\n"

    " Put text to file
    put! =l:text

    " Save new file on disk
    execute 'w'

    " Focus to NERDTree window
    execute 'NERDTreeFocus'

    " refresh NERDTree window to load new file on tab
    execute 'normal R'

endfunction

