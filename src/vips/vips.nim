import std/[strutils]

{.passC: gorge("pkg-config --cflags vips glib-2.0 gobject-2.0").strip.}
{.passL: gorge("pkg-config --libs vips glib-2.0 gobject-2.0").strip.}

type
  VipsImage {.importc: "VipsImage", header: "<vips/vips.h>", incompleteStruct.} = object

proc vips_init(argv0: cstring): cint
  {.importc, header: "<vips/vips.h>".}

proc vips_shutdown()
  {.importc, header: "<vips/vips.h>".}

proc vips_image_new_from_file(name: cstring): ptr VipsImage
  {.importc, varargs, header: "<vips/vips.h>".}

proc vips_image_write_to_file(img: ptr VipsImage, name: cstring): cint
  {.importc, varargs, header: "<vips/vips.h>".}

proc vips_gaussblur(input: ptr VipsImage, output: ptr ptr VipsImage, sigma: cdouble): cint
  {.importc, varargs, header: "<vips/vips.h>".}

proc g_object_unref(obj: pointer)
  {.importc, header: "<glib-object.h>".}

proc blur*(inputPath, outputPath: string, sigma: float) =
  if vips_init("nim-vips") != 0:
    quit("vips_init() failed")

  let input = vips_image_new_from_file(inputPath.cstring, nil)
  if input.isNil:
    vips_shutdown()
    quit("cannot open input image: " & inputPath)

  var output: ptr VipsImage = nil

  if vips_gaussblur(input, addr output, sigma.cdouble, nil) != 0:
    g_object_unref(input)
    vips_shutdown()
    quit("vips_gaussblur() failed")

  if vips_image_write_to_file(output, outputPath.cstring, nil) != 0:
    g_object_unref(output)
    g_object_unref(input)
    vips_shutdown()
    quit("vips_image_write_to_file() failed")

  g_object_unref(output)
  g_object_unref(input)

  vips_shutdown()
