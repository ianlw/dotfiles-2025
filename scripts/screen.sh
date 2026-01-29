#!/bin/sh

# Archivo temporal para la captura de pantalla
name=/tmp/screenshot.png
sleep 0.2

# Capturar una región de la pantalla con grim y slurp
grim -g "$(slurp)" "$name"

# Obtener dimensiones
anchura=$(identify -format %w "$name")
altura=$(identify -format %h "$name")
save_name=/tmp/$(date +%F_%H%M%S)_${altura}x${anchura}.png

# Crear una máscara redondeada con canal alfa correcto
convert -size ${anchura}x${altura} xc:none \
    -draw "fill white roundrectangle 0,0 $anchura,$altura 16,16" \
    PNG32:/tmp/mask.png

# Aplicar la máscara como canal alfa
convert "$name" /tmp/mask.png -compose CopyOpacity -composite PNG32:"$save_name"

# Limpiar archivos temporales
rm "$name" /tmp/mask.png

# Copiar al portapapeles
wl-copy < "$save_name"

# Notificación
dunstify "Copied" -I "$save_name" -t 3000
