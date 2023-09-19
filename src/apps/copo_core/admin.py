from django.contrib import admin

from src.apps.copo_core.models import UserDetails, ViewLock, banner_view, SequencingCenter

admin.site.register(UserDetails)
admin.site.register(ViewLock)
admin.site.register(banner_view)
admin.site.register(SequencingCenter)
