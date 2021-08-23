import opengl
import chroma
import context, vertexbuffer, indexbuffer

type
  Renderer* = object
    context*: Context
    backgroundColor: Color

proc backgroundColor*(renderer: Renderer): Color =
  renderer.backgroundColor

proc `backgroundColor=`*(renderer: Renderer, color: Color) =
  glClearColor(color.r, color.g, color.b, color.a)

proc clear*(renderer: Renderer) =
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)

proc drawBuffer*[V, I](renderer: Renderer,
                       vertices: VertexBuffer[V],
                       indices: IndexBuffer[I]) =
  vertices.selectLayout()
  indices.select()
  glDrawElements(
    GL_TRIANGLES,
    indices.len.GLsizei,
    indices.typeToGlEnum,
    nil
  )

proc drawBuffer*[V](renderer: Renderer,
                    vertices: VertexBuffer[V]) =
  vertices.selectLayout()
  glDrawArrays(
    GL_TRIANGLES,
    0,
    vertices.len.GLsizei,
  )

proc swapFrames*(renderer: Renderer) =
  renderer.context.swapFrames()

proc initRenderer*(context: Context): Renderer =
  result.context = context
  glEnable(GL_DEPTH_TEST)