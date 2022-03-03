;-------------------------------------------------------- 
      
      org 100h 
      page 500 , 50
      title encryption 
      .model small 
      
;--------------------------------------------------------
      
     .stack 64 
     
;--------------------------------------------------------
      
     .data 
     
      print1 db "Enter number of lines ( row ): " 
      print2 db "Enter number of letters in each line ( col ): " 
      print3 db "Enter first number ( for swaping ): " 
      print4 db "Enter second number ( for swaping ): "
      print5 db "Enter Data ( small letters ) : "  
      n_line db 0Ah,0Dh,"$"  
       
      row db ?
      column db ?
      r1 db ?
      r2 db ? 
      
     
      arr db 100 dup(?) 
      temp db ? 
       
;--------------------------------------------------------
      
      .code   
     ;----------ask uesr no of rows -----------
     push ax
     push bx
     push cx
     push dx
              
     
     mov bx ,offset print1
      mov cx,31
    l1:  
     mov dl,[bx]
     mov ah ,2
     int 21h
     inc bx 
     loop l1 
     
     mov ah,1
     int 21h  
     mov row,al
      
     pop dx
     pop cx
     pop bx
     pop ax 
     
     ;----------ask uesr no of columns -----------
     
     lea dx,n_line
     mov ah,9
     int 21h
     
     
      
    mov bx ,offset print2
      mov cx,46
    l2:  
     mov dl,[bx]
     mov ah ,2
     int 21h
     inc bx 
     loop l2 
     
     mov ah,1
     int 21h
     mov column,al  
     
     lea dx,n_line
     mov ah,9
     int 21h
    
     ;______read ______   
     
      mov bx ,offset print5
      mov cx,31
    R:  
     mov dl,[bx]
     mov ah ,2
     int 21h
     inc bx 
     loop R 
     
     lea dx,n_line
     mov ah,9
     int 21h
     
     
     sub row ,30h
     sub column,30h
     
     lea dx,n_line
     mov ah,9
     int 21h
     
    mov bx , offset arr 
     mov cl,row
     lo1:
      mov dl,column
     lo2:
      
      mov ah,1
      int 21h
       mov [bx],ax
       inc bx
      dec dl
      cmp dl,0d
      
      jne lo2  
     lea dx,n_line
     mov ah,9
     int 21h
      
     dec cl 
     cmp cl ,0d
     jne lo1   
     
      lea dx,n_line
     mov ah,9
     int 21h
     
      lea dx,n_line
     mov ah,9
     int 21h 
               
    ;______encryption______
    push ax
    push bx
    push cx
    push dx  
    
    
     mov al , row
     mul column
     
     mov cx , ax
     mov bx,offset arr
     
     le:   
         
        mov dx , [bx]
         
       cmp dl , 'x'
       je tox 
       
        cmp dl , 'y'
       je toy 
       
        cmp dl , 'z'
       je toz  
       
     sub [bx], 29 
     
     back:
     inc bx
     loop le 
     pop dx
     pop cx
     pop bx
     pop ax 
     jmp nextt
     
                
    tox:
    mov [bx] , 'A'
    jmp back  
    
    toy:
    mov [bx] , 'B'
    jmp back
    
    toz:
    mov [bx] , 'C'
    jmp back
              
     ;---------swap rows----------- 
     nextt:     
     push ax
     push bx
     push cx
     push dx 
     
      mov bx ,offset print3
      mov cx,36
    l3:  
     mov dl,[bx]
     mov ah ,2
     int 21h
     inc bx 
     loop l3
     
     mov ah,1
     int 21h
     mov r1,al  
     
     lea dx,n_line
     mov ah,9
     int 21h
     
               
                   
     mov bx ,offset print4
      mov cx,37
    l4:  
     mov dl,[bx]
     mov ah ,2
     int 21h
     inc bx 
     loop l4 
     
     mov ah,1
     int 21h
     mov r2,al  
     
     lea dx,n_line
     mov ah,9
     int 21h
               
     
     mov si , offset arr
     mov di , offset arr  
                     
                     
       sub r1 , 30h
       sub r1 , 1d  
     
     
       cmp r1 , 0 
       je toz1   
      
       
     mov cx , 00h  
     mov ax , 00h
      
     mov al, r1 
     mul column  
     mov cl , al
     
     
     get1:
     inc si
     loop get1 
     
        
     toz1:  
     
      sub r2 , 30h
      sub r2 , 1d  
     
     
       cmp r2 , 0 
       je toz2   
      
       
      mov cx , 00h  
     mov ax , 00h
      
     mov al, r2 
     mul column  
     mov cl , al 
     
     
     get3:
     inc di
     loop get3 
     
     
    
     
     toz2: 
             
     mov cx , 00h   
     mov cl , column
     
     exchange:
     mov al , [si] 
     mov ah , [di]
     mov [si] , ah
     mov [di] , al
     inc si
     inc di
     loop exchange
     
      
     pop dx
     pop cx
     pop bx
     pop ax  
     
     
     
    
    ;________swap cols___________      
     
      
      
     mov cx , 00 
     mov cl , row 
     mov bx , offset arr
       
       
     m1:  
    
     push cx
      
     mov si , bx 
     cmp r1 , 0
     je j1
      
     mov cl , r1 
     m2: 
     inc si
     loop m2 
     
     j1:
     
     mov di , bx 
     cmp r2 , 0
     je exchange2
      
     mov cl , r2 
     m3: 
     inc di
     loop m3
     
     exchange2:
     mov al , [di] 
     mov ah , [si]
     mov [di] , ah
     mov [si] , al
      
     pop cx  
     
     push cx  
     
     mov cl , column 
     m4:
     inc bx 
     loop m4 
     
     pop cx 
     loop m1
       
     
    ;___ print _______ 
         
        
     
    print: 
    push ax
    push bx
    push cx
    push dx  
            
     
     
        
        
        
    
     
     
     mov bx , offset arr 
     mov cl,row
     lo3: 
     
     push ax 
     push bx 
     push dx 
        
    
        mov ax,0200h 
        mov dx,0C28h 
        mov dh , 0Ch
        add dh  , row 
        sub dh , cl
        mov bh,00h
        int 10h
        
         
     pop dx      
     pop bx 
     pop ax 
     
          
     push cx  
     push dx
     mov cx , 15
     
     
     
     
     pop dx 
     pop cx
     
      mov ch,column
     lo4:
       
      mov dx , [bx] 
      inc bx
      mov ah,2
      int 21h
      dec ch
      cmp ch,0d
      jne lo4 
          
      lea dx,n_line
      mov ah,9
      int 21h  
     
      dec cl 
      cmp cl ,0d
      jne lo3  
     
     
     
     pop dx
     pop cx
     pop bx
     pop ax
      
    
     ret 
     
;--------------------------------------------------------