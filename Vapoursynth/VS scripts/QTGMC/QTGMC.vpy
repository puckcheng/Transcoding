import vapoursynth as vs
import sys
import havsfunc as haf

core=vs.get_core(accept_lowercase=True,threads=8)
core.max_cache_size=8000


input=r'\\SERVER-9527\Media\FILM\1920s\The Garbo Silent Collection Disk 3 - The Temptress (1926)\The Temptress.d2v'

ret=core.d2v.Source(input)

clip=haf.QTGMC(ret, Preset='Slow', TFF=True)

clip.set_output()