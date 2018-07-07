return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.0.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 14,
  tilewidth = 128,
  tileheight = 128,
  nextobjectid = 155,
  properties = {},
  tilesets = {
    {
      name = "main_sheet",
      firstgid = 1,
      tilewidth = 128,
      tileheight = 128,
      spacing = 0,
      margin = 0,
      image = "tilesheets/sheet1.png",
      imagewidth = 128,
      imageheight = 128,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 128,
        height = 128
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {}
    },
    {
      name = "3by3",
      firstgid = 2,
      tilewidth = 128,
      tileheight = 128,
      spacing = 0,
      margin = 4,
      image = "tilesheets/3by3_1.png",
      imagewidth = 392,
      imageheight = 392,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 128,
        height = 128
      },
      properties = {},
      terrains = {},
      tilecount = 9,
      tiles = {}
    },
    {
      name = "darkCorners",
      firstgid = 11,
      tilewidth = 128,
      tileheight = 128,
      spacing = 0,
      margin = 4,
      image = "tilesheets/darkCorners_sheet.png",
      imagewidth = 264,
      imageheight = 264,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 128,
        height = 128
      },
      properties = {},
      terrains = {},
      tilecount = 4,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Main_Tiles",
      x = 0,
      y = 0,
      width = 20,
      height = 14,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      data = "AQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAA=="
    },
    {
      type = "objectgroup",
      name = "Window_Size",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "Room",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 121,
          name = "main",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 128,
          width = 2304,
          height = 1536,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "Walls",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 143,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 384,
          height = 1792,
          rotation = 0,
          visible = true,
          properties = {
            ["right"] = true
          }
        },
        {
          id = 144,
          name = "",
          type = "",
          shape = "rectangle",
          x = 2176,
          y = 0,
          width = 384,
          height = 1792,
          rotation = 0,
          visible = true,
          properties = {
            ["left"] = true
          }
        },
        {
          id = 145,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 1408,
          width = 1792,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {
            ["up"] = true
          }
        },
        {
          id = 148,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 0,
          width = 384,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {
            ["dontDraw"] = true
          }
        },
        {
          id = 149,
          name = "",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 0,
          width = 384,
          height = 478,
          rotation = 0,
          visible = true,
          properties = {
            ["dontDraw"] = true
          }
        },
        {
          id = 150,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1408,
          y = 0,
          width = 384,
          height = 478,
          rotation = 0,
          visible = true,
          properties = {
            ["dontDraw"] = true,
            ["spawnX"] = 51
          }
        },
        {
          id = 151,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1792,
          y = 0,
          width = 384,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {
            ["dontDraw"] = true
          }
        },
        {
          id = 152,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1152,
          y = 0,
          width = 256,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {
            ["dontDraw"] = true
          }
        },
        {
          id = 153,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 384,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["dontDraw"] = true
          }
        },
        {
          id = 154,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1792,
          y = 384,
          width = 128,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["dontDraw"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      name = "Transitions",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "Pickups",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "Enemies",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 147,
          name = "boss",
          type = "boss",
          shape = "rectangle",
          x = 1152,
          y = 272,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "Breakables",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "Water",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "Vines",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    }
  }
}