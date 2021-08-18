import opengl
import chroma
import context, gfxbuffer

export chroma
export context, gfxbuffer

type
  Renderer* = object
    context*: Context

proc `backgroundColor=`*(renderer: Renderer, color: Color) =
  glClearColor(color.r, color.g, color.b, color.a)

proc clear*(renderer: Renderer) =
  glClear(GL_COLOR_BUFFER_BIT)

proc drawBuffer*(renderer: Renderer, vertices, indices: var GfxBuffer) =
  vertices.useLayout()
  indices.select()
  glDrawElements(
    GL_TRIANGLES,
    indices.vertexNumValues.GLsizei,
    indices.attributes[0].toGlEnum,
    nil
  )

proc drawBuffer*(renderer: Renderer, vertices: var GfxBuffer) =
  vertices.useLayout()
  glDrawArrays(
    GL_TRIANGLES,
    0,
    vertices.numValues.GLsizei,
  )

proc swapFrames*(renderer: Renderer) =
  renderer.context.swapFrames()

proc initRenderer*(context: Context): Renderer =
  result.context = context