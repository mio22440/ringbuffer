
.\without_quot.o:     file format pe-i386


Disassembly of section .text:

00000000 <_ringbuffer_is_full>:
    do{ \
        (_ringbuffer)->_index_name = (((_ringbuffer)->_index_name + 1) & ((_ringbuffer)->ring_mask)); \
    }while(0)

static inline cat_uint8_t ringbuffer_is_full(ringbuffer_t *p_ringbuffer)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 10             	sub    $0x10,%esp
    cat_uint8_t ret;

    ret = (
        (p_ringbuffer->head_index - p_ringbuffer->tail_index) & (p_ringbuffer->ring_mask) == 
   6:	8b 45 08             	mov    0x8(%ebp),%eax
   9:	8b 40 0c             	mov    0xc(%eax),%eax
   c:	89 c2                	mov    %eax,%edx
   e:	8b 45 08             	mov    0x8(%ebp),%eax
  11:	8b 40 08             	mov    0x8(%eax),%eax
  14:	29 c2                	sub    %eax,%edx
  16:	89 d0                	mov    %edx,%eax
    ret = (
  18:	83 e0 01             	and    $0x1,%eax
  1b:	88 45 ff             	mov    %al,-0x1(%ebp)
        (p_ringbuffer->ring_mask)
        );

    return ret;
  1e:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
  22:	c9                   	leave  
  23:	c3                   	ret    

00000024 <_ringbuffer_is_empty>:

static inline cat_uint8_t ringbuffer_is_empty(ringbuffer_t *p_ringbuffer)
{
  24:	55                   	push   %ebp
  25:	89 e5                	mov    %esp,%ebp
  27:	83 ec 10             	sub    $0x10,%esp
    cat_uint8_t ret;

    ret = ((p_ringbuffer->head_index) == (p_ringbuffer->tail_index));
  2a:	8b 45 08             	mov    0x8(%ebp),%eax
  2d:	8b 50 0c             	mov    0xc(%eax),%edx
  30:	8b 45 08             	mov    0x8(%ebp),%eax
  33:	8b 40 08             	mov    0x8(%eax),%eax
  36:	39 c2                	cmp    %eax,%edx
  38:	0f 94 c0             	sete   %al
  3b:	88 45 ff             	mov    %al,-0x1(%ebp)

    return ret;
  3e:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
  42:	c9                   	leave  
  43:	c3                   	ret    

00000044 <_ringbuffer_init>:

void ringbuffer_init(ringbuffer_t *p_ringbuffer, cat_uint8_t *p_buffer_space, cat_uint32_t buffer_size)
{
  44:	55                   	push   %ebp
  45:	89 e5                	mov    %esp,%ebp
  47:	83 ec 18             	sub    $0x18,%esp
    CAT_ASSERT(NULL != p_ringbuffer);
  4a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  4e:	75 26                	jne    76 <_ringbuffer_init+0x32>
  50:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  57:	00 
  58:	c7 44 24 08 42 00 00 	movl   $0x42,0x8(%esp)
  5f:	00 
  60:	c7 44 24 04 15 00 00 	movl   $0x15,0x4(%esp)
  67:	00 
  68:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  6f:	e8 00 00 00 00       	call   74 <_ringbuffer_init+0x30>
  74:	eb fe                	jmp    74 <_ringbuffer_init+0x30>
    CAT_ASSERT(NULL != p_buffer_space);
  76:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  7a:	75 26                	jne    a2 <_ringbuffer_init+0x5e>
  7c:	c7 44 24 0c 43 00 00 	movl   $0x43,0xc(%esp)
  83:	00 
  84:	c7 44 24 08 43 00 00 	movl   $0x43,0x8(%esp)
  8b:	00 
  8c:	c7 44 24 04 15 00 00 	movl   $0x15,0x4(%esp)
  93:	00 
  94:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  9b:	e8 00 00 00 00       	call   a0 <_ringbuffer_init+0x5c>
  a0:	eb fe                	jmp    a0 <_ringbuffer_init+0x5c>
    //CAT_ASSERT(buffer_size >= MIN_RINGBUFFER_SIZE);
    /* 濡傛灉瑕佷娇鐢╮ing_mask鏉ヤ唬鏇垮彇浣欐搷浣滃疄鐜板惊鐜紝buffer澶у皬蹇呴』涓?鐨刵娆℃柟 */
    CAT_ASSERT(1 == (IS_POWER_OF_TWO(buffer_size)));
  a2:	8b 45 10             	mov    0x10(%ebp),%eax
  a5:	83 e8 01             	sub    $0x1,%eax
  a8:	23 45 10             	and    0x10(%ebp),%eax
  ab:	85 c0                	test   %eax,%eax
  ad:	74 26                	je     d5 <_ringbuffer_init+0x91>
  af:	c7 44 24 0c 5c 00 00 	movl   $0x5c,0xc(%esp)
  b6:	00 
  b7:	c7 44 24 08 46 00 00 	movl   $0x46,0x8(%esp)
  be:	00 
  bf:	c7 44 24 04 15 00 00 	movl   $0x15,0x4(%esp)
  c6:	00 
  c7:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  ce:	e8 00 00 00 00       	call   d3 <_ringbuffer_init+0x8f>
  d3:	eb fe                	jmp    d3 <_ringbuffer_init+0x8f>

    p_ringbuffer->p_buffer       = p_buffer_space;
  d5:	8b 45 08             	mov    0x8(%ebp),%eax
  d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  db:	89 10                	mov    %edx,(%eax)
    p_ringbuffer->ring_mask      = buffer_size - 1;
  dd:	8b 45 10             	mov    0x10(%ebp),%eax
  e0:	8d 50 ff             	lea    -0x1(%eax),%edx
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	89 50 04             	mov    %edx,0x4(%eax)
    p_ringbuffer->tail_index     = 0;
  e9:	8b 45 08             	mov    0x8(%ebp),%eax
  ec:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    p_ringbuffer->head_index     = 0;
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
}
  fd:	90                   	nop
  fe:	c9                   	leave  
  ff:	c3                   	ret    

00000100 <_ringbuffer_clear>:

void ringbuffer_clear(ringbuffer_t *p_ringbuffer)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	83 ec 18             	sub    $0x18,%esp
    CAT_ASSERT(NULL != p_ringbuffer);
 106:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 10a:	75 26                	jne    132 <_ringbuffer_clear+0x32>
 10c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 113:	00 
 114:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
 11b:	00 
 11c:	c7 44 24 04 15 00 00 	movl   $0x15,0x4(%esp)
 123:	00 
 124:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
 12b:	e8 00 00 00 00       	call   130 <_ringbuffer_clear+0x30>
 130:	eb fe                	jmp    130 <_ringbuffer_clear+0x30>
    p_ringbuffer->tail_index     = 0;
 132:	8b 45 08             	mov    0x8(%ebp),%eax
 135:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    p_ringbuffer->head_index     = 0;
 13c:	8b 45 08             	mov    0x8(%ebp),%eax
 13f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
}
 146:	90                   	nop
 147:	c9                   	leave  
 148:	c3                   	ret    

00000149 <_ringbuffer_put>:

cat_int32_t ringbuffer_put(ringbuffer_t *p_ringbuffer, cat_uint8_t data)
{
 149:	55                   	push   %ebp
 14a:	89 e5                	mov    %esp,%ebp
 14c:	83 ec 38             	sub    $0x38,%esp
 14f:	8b 45 0c             	mov    0xc(%ebp),%eax
 152:	88 45 e4             	mov    %al,-0x1c(%ebp)
    cat_int32_t ret = CAT_ERROR;
 155:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)

    if(0 != ringbuffer_is_full(p_ringbuffer))
 15c:	8b 45 08             	mov    0x8(%ebp),%eax
 15f:	89 04 24             	mov    %eax,(%esp)
 162:	e8 99 fe ff ff       	call   0 <_ringbuffer_is_full>
 167:	84 c0                	test   %al,%al
 169:	74 23                	je     18e <_ringbuffer_put+0x45>
    {
        /* 濡傛灉婊′簡灏辫鐩栨渶鏃╃殑 */
        CAT_SYS_PRINTF("[ringbuffer] buffer overflow\r\n");
 16b:	c7 04 24 80 00 00 00 	movl   $0x80,(%esp)
 172:	e8 00 00 00 00       	call   177 <_ringbuffer_put+0x2e>
        
        /* 灏鹃儴绱㈠紩寰€鍓嶈蛋 */
        //p_ringbuffer->tail_index = ((p_ringbuffer->tail_index + 1) & (p_ringbuffer->ring_mask));
        RINGBUFFER_INDEX_MOVE_FOWARD(p_ringbuffer, tail_index);
 177:	8b 45 08             	mov    0x8(%ebp),%eax
 17a:	8b 40 08             	mov    0x8(%eax),%eax
 17d:	8d 50 01             	lea    0x1(%eax),%edx
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	8b 40 04             	mov    0x4(%eax),%eax
 186:	21 c2                	and    %eax,%edx
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	89 50 08             	mov    %edx,0x8(%eax)
    }

    p_ringbuffer->p_buffer[p_ringbuffer->head_index] = data;
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	8b 10                	mov    (%eax),%edx
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	8b 40 0c             	mov    0xc(%eax),%eax
 199:	01 c2                	add    %eax,%edx
 19b:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
 19f:	88 02                	mov    %al,(%edx)
    //p_ringbuffer->head_index = ((p_ringbuffer->head_index + 1) & (p_ringbuffer->ring_mask));
    RINGBUFFER_INDEX_MOVE_FOWARD(p_ringbuffer, head_index);
 1a1:	8b 45 08             	mov    0x8(%ebp),%eax
 1a4:	8b 40 0c             	mov    0xc(%eax),%eax
 1a7:	8d 50 01             	lea    0x1(%eax),%edx
 1aa:	8b 45 08             	mov    0x8(%ebp),%eax
 1ad:	8b 40 04             	mov    0x4(%eax),%eax
 1b0:	21 c2                	and    %eax,%edx
 1b2:	8b 45 08             	mov    0x8(%ebp),%eax
 1b5:	89 50 0c             	mov    %edx,0xc(%eax)

    ret = CAT_EOK;
 1b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    return ret;
 1bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 1c2:	c9                   	leave  
 1c3:	c3                   	ret    

000001c4 <_ringbuffer_get>:


cat_int32_t ringbuffer_get(ringbuffer_t *p_ringbuffer, cat_uint8_t *p_data)
{
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	83 ec 14             	sub    $0x14,%esp
    cat_int32_t ret = CAT_ERROR;
 1ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

    if(0 == ringbuffer_is_empty(p_ringbuffer))
 1d1:	8b 45 08             	mov    0x8(%ebp),%eax
 1d4:	89 04 24             	mov    %eax,(%esp)
 1d7:	e8 48 fe ff ff       	call   24 <_ringbuffer_is_empty>
 1dc:	84 c0                	test   %al,%al
 1de:	75 33                	jne    213 <_ringbuffer_get+0x4f>
    {
        /* 涓嶄负绌烘墠鎵ц */
        *p_data = p_ringbuffer->p_buffer[p_ringbuffer->tail_index];
 1e0:	8b 45 08             	mov    0x8(%ebp),%eax
 1e3:	8b 10                	mov    (%eax),%edx
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	8b 40 08             	mov    0x8(%eax),%eax
 1eb:	01 d0                	add    %edx,%eax
 1ed:	0f b6 10             	movzbl (%eax),%edx
 1f0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f3:	88 10                	mov    %dl,(%eax)
        //p_ringbuffer->tail_index = ((p_ringbuffer->tail_index + 1) & (p_ringbuffer->ring_mask));
        RINGBUFFER_INDEX_MOVE_FOWARD(p_ringbuffer, tail_index);
 1f5:	8b 45 08             	mov    0x8(%ebp),%eax
 1f8:	8b 40 08             	mov    0x8(%eax),%eax
 1fb:	8d 50 01             	lea    0x1(%eax),%edx
 1fe:	8b 45 08             	mov    0x8(%ebp),%eax
 201:	8b 40 04             	mov    0x4(%eax),%eax
 204:	21 c2                	and    %eax,%edx
 206:	8b 45 08             	mov    0x8(%ebp),%eax
 209:	89 50 08             	mov    %edx,0x8(%eax)

        ret = CAT_EOK;
 20c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    }

    return ret;
 213:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 216:	c9                   	leave  
 217:	c3                   	ret    

00000218 <_ringbuffer_put_more>:

cat_int32_t ringbuffer_put_more(ringbuffer_t *p_ringbuffer, const cat_uint8_t *p_data, cat_uint32_t size)
{
 218:	55                   	push   %ebp
 219:	89 e5                	mov    %esp,%ebp
 21b:	83 ec 28             	sub    $0x28,%esp
    cat_int32_t ret = 0;
 21e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cat_uint32_t i = 0;
 225:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

    for(i=0; i<size; i++)
 22c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 233:	eb 24                	jmp    259 <_ringbuffer_put_more+0x41>
    {
        ret += ringbuffer_put(p_ringbuffer, p_data[i]);
 235:	8b 55 0c             	mov    0xc(%ebp),%edx
 238:	8b 45 f0             	mov    -0x10(%ebp),%eax
 23b:	01 d0                	add    %edx,%eax
 23d:	0f b6 00             	movzbl (%eax),%eax
 240:	0f b6 c0             	movzbl %al,%eax
 243:	89 44 24 04          	mov    %eax,0x4(%esp)
 247:	8b 45 08             	mov    0x8(%ebp),%eax
 24a:	89 04 24             	mov    %eax,(%esp)
 24d:	e8 f7 fe ff ff       	call   149 <_ringbuffer_put>
 252:	01 45 f4             	add    %eax,-0xc(%ebp)
    for(i=0; i<size; i++)
 255:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 259:	8b 45 f0             	mov    -0x10(%ebp),%eax
 25c:	3b 45 10             	cmp    0x10(%ebp),%eax
 25f:	72 d4                	jb     235 <_ringbuffer_put_more+0x1d>
    }

    if(0 != ret)
 261:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 265:	74 07                	je     26e <_ringbuffer_put_more+0x56>
    {
        ret = CAT_ERROR;
 267:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    }

    return ret;
 26e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 271:	c9                   	leave  
 272:	c3                   	ret    

00000273 <_ringbuffer_get_more>:

cat_uint32_t ringbuffer_get_more(ringbuffer_t *p_ringbuffer, cat_uint8_t *p_data, cat_uint32_t size)
{
 273:	55                   	push   %ebp
 274:	89 e5                	mov    %esp,%ebp
 276:	83 ec 18             	sub    $0x18,%esp
    cat_int32_t err = CAT_ERROR;
 279:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    cat_uint8_t *p = NULL;
 280:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    cat_uint32_t cnt = 0;
 287:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)


    if(0 == ringbuffer_is_empty(p_ringbuffer))
 28e:	8b 45 08             	mov    0x8(%ebp),%eax
 291:	89 04 24             	mov    %eax,(%esp)
 294:	e8 8b fd ff ff       	call   24 <_ringbuffer_is_empty>
 299:	84 c0                	test   %al,%al
 29b:	75 38                	jne    2d5 <_ringbuffer_get_more+0x62>
    {
        /* 涓嶄负绌烘墠缁х画 */
        p   = p_data;
 29d:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
        cnt = 0;
 2a3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

        do{
            err = ringbuffer_get(p_ringbuffer, p);
 2aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 2b1:	8b 45 08             	mov    0x8(%ebp),%eax
 2b4:	89 04 24             	mov    %eax,(%esp)
 2b7:	e8 08 ff ff ff       	call   1c4 <_ringbuffer_get>
 2bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
            cnt++;
 2bf:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
            p++;
 2c3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
        }while(
            (cnt < size) &&
            (CAT_EOK == err)
        );
 2c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2ca:	3b 45 10             	cmp    0x10(%ebp),%eax
 2cd:	73 06                	jae    2d5 <_ringbuffer_get_more+0x62>
            (cnt < size) &&
 2cf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2d3:	74 d5                	je     2aa <_ringbuffer_get_more+0x37>

    }

    return cnt;
 2d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
 2d8:	c9                   	leave  
 2d9:	c3                   	ret    

000002da <_ringbuffer_print_all>:

/* 娴嬭瘯鐢ㄥ嚱鏁?*/
void ringbuffer_print_all(ringbuffer_t *p_ringbuffer)
{
 2da:	55                   	push   %ebp
 2db:	89 e5                	mov    %esp,%ebp
 2dd:	83 ec 28             	sub    $0x28,%esp
    cat_uint32_t idx = p_ringbuffer->tail_index;
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
 2e3:	8b 40 08             	mov    0x8(%eax),%eax
 2e6:	89 45 f4             	mov    %eax,-0xc(%ebp)

    printf("************\n****tail=%2d, head=%2d****\n", (p_ringbuffer->tail_index), (p_ringbuffer->head_index));
 2e9:	8b 45 08             	mov    0x8(%ebp),%eax
 2ec:	8b 50 0c             	mov    0xc(%eax),%edx
 2ef:	8b 45 08             	mov    0x8(%ebp),%eax
 2f2:	8b 40 08             	mov    0x8(%eax),%eax
 2f5:	89 54 24 08          	mov    %edx,0x8(%esp)
 2f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2fd:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
 304:	e8 00 00 00 00       	call   309 <_ringbuffer_print_all+0x2f>
    while(idx != (p_ringbuffer->head_index))
 309:	eb 38                	jmp    343 <_ringbuffer_print_all+0x69>
    {
        printf("index=%2d, data=0x%x\n", idx, p_ringbuffer->p_buffer[idx]);
 30b:	8b 45 08             	mov    0x8(%ebp),%eax
 30e:	8b 10                	mov    (%eax),%edx
 310:	8b 45 f4             	mov    -0xc(%ebp),%eax
 313:	01 d0                	add    %edx,%eax
 315:	0f b6 00             	movzbl (%eax),%eax
 318:	0f b6 c0             	movzbl %al,%eax
 31b:	89 44 24 08          	mov    %eax,0x8(%esp)
 31f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 322:	89 44 24 04          	mov    %eax,0x4(%esp)
 326:	c7 04 24 c9 00 00 00 	movl   $0xc9,(%esp)
 32d:	e8 00 00 00 00       	call   332 <_ringbuffer_print_all+0x58>
        idx = (idx + 1) & (p_ringbuffer->ring_mask);
 332:	8b 45 f4             	mov    -0xc(%ebp),%eax
 335:	8d 50 01             	lea    0x1(%eax),%edx
 338:	8b 45 08             	mov    0x8(%ebp),%eax
 33b:	8b 40 04             	mov    0x4(%eax),%eax
 33e:	21 d0                	and    %edx,%eax
 340:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(idx != (p_ringbuffer->head_index))
 343:	8b 45 08             	mov    0x8(%ebp),%eax
 346:	8b 40 0c             	mov    0xc(%eax),%eax
 349:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 34c:	75 bd                	jne    30b <_ringbuffer_print_all+0x31>
    }
}
 34e:	90                   	nop
 34f:	c9                   	leave  
 350:	c3                   	ret    
 351:	90                   	nop
 352:	90                   	nop
 353:	90                   	nop
