
.\with_quot.o:     file format pe-i386


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
        ((p_ringbuffer->head_index - p_ringbuffer->tail_index) & (p_ringbuffer->ring_mask)) == 
   6:	8b 45 08             	mov    0x8(%ebp),%eax
   9:	8b 50 0c             	mov    0xc(%eax),%edx
   c:	8b 45 08             	mov    0x8(%ebp),%eax
   f:	8b 40 08             	mov    0x8(%eax),%eax
  12:	29 c2                	sub    %eax,%edx
  14:	8b 45 08             	mov    0x8(%ebp),%eax
  17:	8b 40 04             	mov    0x4(%eax),%eax
  1a:	21 c2                	and    %eax,%edx
        (p_ringbuffer->ring_mask)
  1c:	8b 45 08             	mov    0x8(%ebp),%eax
  1f:	8b 40 04             	mov    0x4(%eax),%eax
        ((p_ringbuffer->head_index - p_ringbuffer->tail_index) & (p_ringbuffer->ring_mask)) == 
  22:	39 c2                	cmp    %eax,%edx
  24:	0f 94 c0             	sete   %al
    ret = (
  27:	88 45 ff             	mov    %al,-0x1(%ebp)
        );

    return ret;
  2a:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
  2e:	c9                   	leave  
  2f:	c3                   	ret    

00000030 <_ringbuffer_is_empty>:

static inline cat_uint8_t ringbuffer_is_empty(ringbuffer_t *p_ringbuffer)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	83 ec 10             	sub    $0x10,%esp
    cat_uint8_t ret;

    ret = ((p_ringbuffer->head_index) == (p_ringbuffer->tail_index));
  36:	8b 45 08             	mov    0x8(%ebp),%eax
  39:	8b 50 0c             	mov    0xc(%eax),%edx
  3c:	8b 45 08             	mov    0x8(%ebp),%eax
  3f:	8b 40 08             	mov    0x8(%eax),%eax
  42:	39 c2                	cmp    %eax,%edx
  44:	0f 94 c0             	sete   %al
  47:	88 45 ff             	mov    %al,-0x1(%ebp)

    return ret;
  4a:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
  4e:	c9                   	leave  
  4f:	c3                   	ret    

00000050 <_ringbuffer_init>:

void ringbuffer_init(ringbuffer_t *p_ringbuffer, cat_uint8_t *p_buffer_space, cat_uint32_t buffer_size)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	83 ec 18             	sub    $0x18,%esp
    CAT_ASSERT(NULL != p_ringbuffer);
  56:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  5a:	75 26                	jne    82 <_ringbuffer_init+0x32>
  5c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  63:	00 
  64:	c7 44 24 08 42 00 00 	movl   $0x42,0x8(%esp)
  6b:	00 
  6c:	c7 44 24 04 15 00 00 	movl   $0x15,0x4(%esp)
  73:	00 
  74:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  7b:	e8 00 00 00 00       	call   80 <_ringbuffer_init+0x30>
  80:	eb fe                	jmp    80 <_ringbuffer_init+0x30>
    CAT_ASSERT(NULL != p_buffer_space);
  82:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  86:	75 26                	jne    ae <_ringbuffer_init+0x5e>
  88:	c7 44 24 0c 43 00 00 	movl   $0x43,0xc(%esp)
  8f:	00 
  90:	c7 44 24 08 43 00 00 	movl   $0x43,0x8(%esp)
  97:	00 
  98:	c7 44 24 04 15 00 00 	movl   $0x15,0x4(%esp)
  9f:	00 
  a0:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  a7:	e8 00 00 00 00       	call   ac <_ringbuffer_init+0x5c>
  ac:	eb fe                	jmp    ac <_ringbuffer_init+0x5c>
    //CAT_ASSERT(buffer_size >= MIN_RINGBUFFER_SIZE);
    /* 濡傛灉瑕佷娇鐢╮ing_mask鏉ヤ唬鏇垮彇浣欐搷浣滃疄鐜板惊鐜紝buffer澶у皬蹇呴』涓?鐨刵娆℃柟 */
    CAT_ASSERT(1 == (IS_POWER_OF_TWO(buffer_size)));
  ae:	8b 45 10             	mov    0x10(%ebp),%eax
  b1:	83 e8 01             	sub    $0x1,%eax
  b4:	23 45 10             	and    0x10(%ebp),%eax
  b7:	85 c0                	test   %eax,%eax
  b9:	74 26                	je     e1 <_ringbuffer_init+0x91>
  bb:	c7 44 24 0c 5c 00 00 	movl   $0x5c,0xc(%esp)
  c2:	00 
  c3:	c7 44 24 08 46 00 00 	movl   $0x46,0x8(%esp)
  ca:	00 
  cb:	c7 44 24 04 15 00 00 	movl   $0x15,0x4(%esp)
  d2:	00 
  d3:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
  da:	e8 00 00 00 00       	call   df <_ringbuffer_init+0x8f>
  df:	eb fe                	jmp    df <_ringbuffer_init+0x8f>

    p_ringbuffer->p_buffer       = p_buffer_space;
  e1:	8b 45 08             	mov    0x8(%ebp),%eax
  e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  e7:	89 10                	mov    %edx,(%eax)
    p_ringbuffer->ring_mask      = buffer_size - 1;
  e9:	8b 45 10             	mov    0x10(%ebp),%eax
  ec:	8d 50 ff             	lea    -0x1(%eax),%edx
  ef:	8b 45 08             	mov    0x8(%ebp),%eax
  f2:	89 50 04             	mov    %edx,0x4(%eax)
    p_ringbuffer->tail_index     = 0;
  f5:	8b 45 08             	mov    0x8(%ebp),%eax
  f8:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    p_ringbuffer->head_index     = 0;
  ff:	8b 45 08             	mov    0x8(%ebp),%eax
 102:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
}
 109:	90                   	nop
 10a:	c9                   	leave  
 10b:	c3                   	ret    

0000010c <_ringbuffer_clear>:

void ringbuffer_clear(ringbuffer_t *p_ringbuffer)
{
 10c:	55                   	push   %ebp
 10d:	89 e5                	mov    %esp,%ebp
 10f:	83 ec 18             	sub    $0x18,%esp
    CAT_ASSERT(NULL != p_ringbuffer);
 112:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 116:	75 26                	jne    13e <_ringbuffer_clear+0x32>
 118:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 11f:	00 
 120:	c7 44 24 08 50 00 00 	movl   $0x50,0x8(%esp)
 127:	00 
 128:	c7 44 24 04 15 00 00 	movl   $0x15,0x4(%esp)
 12f:	00 
 130:	c7 04 24 28 00 00 00 	movl   $0x28,(%esp)
 137:	e8 00 00 00 00       	call   13c <_ringbuffer_clear+0x30>
 13c:	eb fe                	jmp    13c <_ringbuffer_clear+0x30>
    p_ringbuffer->tail_index     = 0;
 13e:	8b 45 08             	mov    0x8(%ebp),%eax
 141:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    p_ringbuffer->head_index     = 0;
 148:	8b 45 08             	mov    0x8(%ebp),%eax
 14b:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
}
 152:	90                   	nop
 153:	c9                   	leave  
 154:	c3                   	ret    

00000155 <_ringbuffer_put>:

cat_int32_t ringbuffer_put(ringbuffer_t *p_ringbuffer, cat_uint8_t data)
{
 155:	55                   	push   %ebp
 156:	89 e5                	mov    %esp,%ebp
 158:	83 ec 38             	sub    $0x38,%esp
 15b:	8b 45 0c             	mov    0xc(%ebp),%eax
 15e:	88 45 e4             	mov    %al,-0x1c(%ebp)
    cat_int32_t ret = CAT_ERROR;
 161:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)

    if(0 != ringbuffer_is_full(p_ringbuffer))
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	89 04 24             	mov    %eax,(%esp)
 16e:	e8 8d fe ff ff       	call   0 <_ringbuffer_is_full>
 173:	84 c0                	test   %al,%al
 175:	74 23                	je     19a <_ringbuffer_put+0x45>
    {
        /* 濡傛灉婊′簡灏辫鐩栨渶鏃╃殑 */
        CAT_SYS_PRINTF("[ringbuffer] buffer overflow\r\n");
 177:	c7 04 24 80 00 00 00 	movl   $0x80,(%esp)
 17e:	e8 00 00 00 00       	call   183 <_ringbuffer_put+0x2e>
        
        /* 灏鹃儴绱㈠紩寰€鍓嶈蛋 */
        //p_ringbuffer->tail_index = ((p_ringbuffer->tail_index + 1) & (p_ringbuffer->ring_mask));
        RINGBUFFER_INDEX_MOVE_FOWARD(p_ringbuffer, tail_index);
 183:	8b 45 08             	mov    0x8(%ebp),%eax
 186:	8b 40 08             	mov    0x8(%eax),%eax
 189:	8d 50 01             	lea    0x1(%eax),%edx
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	8b 40 04             	mov    0x4(%eax),%eax
 192:	21 c2                	and    %eax,%edx
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	89 50 08             	mov    %edx,0x8(%eax)
    }

    p_ringbuffer->p_buffer[p_ringbuffer->head_index] = data;
 19a:	8b 45 08             	mov    0x8(%ebp),%eax
 19d:	8b 10                	mov    (%eax),%edx
 19f:	8b 45 08             	mov    0x8(%ebp),%eax
 1a2:	8b 40 0c             	mov    0xc(%eax),%eax
 1a5:	01 c2                	add    %eax,%edx
 1a7:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
 1ab:	88 02                	mov    %al,(%edx)
    //p_ringbuffer->head_index = ((p_ringbuffer->head_index + 1) & (p_ringbuffer->ring_mask));
    RINGBUFFER_INDEX_MOVE_FOWARD(p_ringbuffer, head_index);
 1ad:	8b 45 08             	mov    0x8(%ebp),%eax
 1b0:	8b 40 0c             	mov    0xc(%eax),%eax
 1b3:	8d 50 01             	lea    0x1(%eax),%edx
 1b6:	8b 45 08             	mov    0x8(%ebp),%eax
 1b9:	8b 40 04             	mov    0x4(%eax),%eax
 1bc:	21 c2                	and    %eax,%edx
 1be:	8b 45 08             	mov    0x8(%ebp),%eax
 1c1:	89 50 0c             	mov    %edx,0xc(%eax)

    ret = CAT_EOK;
 1c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    return ret;
 1cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 1ce:	c9                   	leave  
 1cf:	c3                   	ret    

000001d0 <_ringbuffer_get>:


cat_int32_t ringbuffer_get(ringbuffer_t *p_ringbuffer, cat_uint8_t *p_data)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 14             	sub    $0x14,%esp
    cat_int32_t ret = CAT_ERROR;
 1d6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

    if(0 == ringbuffer_is_empty(p_ringbuffer))
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
 1e0:	89 04 24             	mov    %eax,(%esp)
 1e3:	e8 48 fe ff ff       	call   30 <_ringbuffer_is_empty>
 1e8:	84 c0                	test   %al,%al
 1ea:	75 33                	jne    21f <_ringbuffer_get+0x4f>
    {
        /* 涓嶄负绌烘墠鎵ц */
        *p_data = p_ringbuffer->p_buffer[p_ringbuffer->tail_index];
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	8b 10                	mov    (%eax),%edx
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
 1f4:	8b 40 08             	mov    0x8(%eax),%eax
 1f7:	01 d0                	add    %edx,%eax
 1f9:	0f b6 10             	movzbl (%eax),%edx
 1fc:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ff:	88 10                	mov    %dl,(%eax)
        //p_ringbuffer->tail_index = ((p_ringbuffer->tail_index + 1) & (p_ringbuffer->ring_mask));
        RINGBUFFER_INDEX_MOVE_FOWARD(p_ringbuffer, tail_index);
 201:	8b 45 08             	mov    0x8(%ebp),%eax
 204:	8b 40 08             	mov    0x8(%eax),%eax
 207:	8d 50 01             	lea    0x1(%eax),%edx
 20a:	8b 45 08             	mov    0x8(%ebp),%eax
 20d:	8b 40 04             	mov    0x4(%eax),%eax
 210:	21 c2                	and    %eax,%edx
 212:	8b 45 08             	mov    0x8(%ebp),%eax
 215:	89 50 08             	mov    %edx,0x8(%eax)

        ret = CAT_EOK;
 218:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    }

    return ret;
 21f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 222:	c9                   	leave  
 223:	c3                   	ret    

00000224 <_ringbuffer_put_more>:

cat_int32_t ringbuffer_put_more(ringbuffer_t *p_ringbuffer, const cat_uint8_t *p_data, cat_uint32_t size)
{
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	83 ec 28             	sub    $0x28,%esp
    cat_int32_t ret = 0;
 22a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cat_uint32_t i = 0;
 231:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

    for(i=0; i<size; i++)
 238:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 23f:	eb 24                	jmp    265 <_ringbuffer_put_more+0x41>
    {
        ret += ringbuffer_put(p_ringbuffer, p_data[i]);
 241:	8b 55 0c             	mov    0xc(%ebp),%edx
 244:	8b 45 f0             	mov    -0x10(%ebp),%eax
 247:	01 d0                	add    %edx,%eax
 249:	0f b6 00             	movzbl (%eax),%eax
 24c:	0f b6 c0             	movzbl %al,%eax
 24f:	89 44 24 04          	mov    %eax,0x4(%esp)
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	89 04 24             	mov    %eax,(%esp)
 259:	e8 f7 fe ff ff       	call   155 <_ringbuffer_put>
 25e:	01 45 f4             	add    %eax,-0xc(%ebp)
    for(i=0; i<size; i++)
 261:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 265:	8b 45 f0             	mov    -0x10(%ebp),%eax
 268:	3b 45 10             	cmp    0x10(%ebp),%eax
 26b:	72 d4                	jb     241 <_ringbuffer_put_more+0x1d>
    }

    if(0 != ret)
 26d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 271:	74 07                	je     27a <_ringbuffer_put_more+0x56>
    {
        ret = CAT_ERROR;
 273:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    }

    return ret;
 27a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 27d:	c9                   	leave  
 27e:	c3                   	ret    

0000027f <_ringbuffer_get_more>:

cat_uint32_t ringbuffer_get_more(ringbuffer_t *p_ringbuffer, cat_uint8_t *p_data, cat_uint32_t size)
{
 27f:	55                   	push   %ebp
 280:	89 e5                	mov    %esp,%ebp
 282:	83 ec 18             	sub    $0x18,%esp
    cat_int32_t err = CAT_ERROR;
 285:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    cat_uint8_t *p = NULL;
 28c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    cat_uint32_t cnt = 0;
 293:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)


    if(0 == ringbuffer_is_empty(p_ringbuffer))
 29a:	8b 45 08             	mov    0x8(%ebp),%eax
 29d:	89 04 24             	mov    %eax,(%esp)
 2a0:	e8 8b fd ff ff       	call   30 <_ringbuffer_is_empty>
 2a5:	84 c0                	test   %al,%al
 2a7:	75 38                	jne    2e1 <_ringbuffer_get_more+0x62>
    {
        /* 涓嶄负绌烘墠缁х画 */
        p   = p_data;
 2a9:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
        cnt = 0;
 2af:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

        do{
            err = ringbuffer_get(p_ringbuffer, p);
 2b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 2bd:	8b 45 08             	mov    0x8(%ebp),%eax
 2c0:	89 04 24             	mov    %eax,(%esp)
 2c3:	e8 08 ff ff ff       	call   1d0 <_ringbuffer_get>
 2c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
            cnt++;
 2cb:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
            p++;
 2cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
        }while(
            (cnt < size) &&
            (CAT_EOK == err)
        );
 2d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2d6:	3b 45 10             	cmp    0x10(%ebp),%eax
 2d9:	73 06                	jae    2e1 <_ringbuffer_get_more+0x62>
            (cnt < size) &&
 2db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2df:	74 d5                	je     2b6 <_ringbuffer_get_more+0x37>

    }

    return cnt;
 2e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
 2e4:	c9                   	leave  
 2e5:	c3                   	ret    

000002e6 <_ringbuffer_print_all>:

/* 娴嬭瘯鐢ㄥ嚱鏁?*/
void ringbuffer_print_all(ringbuffer_t *p_ringbuffer)
{
 2e6:	55                   	push   %ebp
 2e7:	89 e5                	mov    %esp,%ebp
 2e9:	83 ec 28             	sub    $0x28,%esp
    cat_uint32_t idx = p_ringbuffer->tail_index;
 2ec:	8b 45 08             	mov    0x8(%ebp),%eax
 2ef:	8b 40 08             	mov    0x8(%eax),%eax
 2f2:	89 45 f4             	mov    %eax,-0xc(%ebp)

    printf("************\n****tail=%2d, head=%2d****\n", (p_ringbuffer->tail_index), (p_ringbuffer->head_index));
 2f5:	8b 45 08             	mov    0x8(%ebp),%eax
 2f8:	8b 50 0c             	mov    0xc(%eax),%edx
 2fb:	8b 45 08             	mov    0x8(%ebp),%eax
 2fe:	8b 40 08             	mov    0x8(%eax),%eax
 301:	89 54 24 08          	mov    %edx,0x8(%esp)
 305:	89 44 24 04          	mov    %eax,0x4(%esp)
 309:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
 310:	e8 00 00 00 00       	call   315 <_ringbuffer_print_all+0x2f>
    while(idx != (p_ringbuffer->head_index))
 315:	eb 38                	jmp    34f <_ringbuffer_print_all+0x69>
    {
        printf("index=%2d, data=0x%x\n", idx, p_ringbuffer->p_buffer[idx]);
 317:	8b 45 08             	mov    0x8(%ebp),%eax
 31a:	8b 10                	mov    (%eax),%edx
 31c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 31f:	01 d0                	add    %edx,%eax
 321:	0f b6 00             	movzbl (%eax),%eax
 324:	0f b6 c0             	movzbl %al,%eax
 327:	89 44 24 08          	mov    %eax,0x8(%esp)
 32b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 32e:	89 44 24 04          	mov    %eax,0x4(%esp)
 332:	c7 04 24 c9 00 00 00 	movl   $0xc9,(%esp)
 339:	e8 00 00 00 00       	call   33e <_ringbuffer_print_all+0x58>
        idx = (idx + 1) & (p_ringbuffer->ring_mask);
 33e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 341:	8d 50 01             	lea    0x1(%eax),%edx
 344:	8b 45 08             	mov    0x8(%ebp),%eax
 347:	8b 40 04             	mov    0x4(%eax),%eax
 34a:	21 d0                	and    %edx,%eax
 34c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(idx != (p_ringbuffer->head_index))
 34f:	8b 45 08             	mov    0x8(%ebp),%eax
 352:	8b 40 0c             	mov    0xc(%eax),%eax
 355:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 358:	75 bd                	jne    317 <_ringbuffer_print_all+0x31>
    }
}
 35a:	90                   	nop
 35b:	c9                   	leave  
 35c:	c3                   	ret    
 35d:	90                   	nop
 35e:	90                   	nop
 35f:	90                   	nop
