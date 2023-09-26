<template>
  <div class="sticky top-0 z-40 flex h-16 shrink-0 items-center gap-x-4 border-b border-gray-200 dark:border-neutral-700 bg-white dark:bg-neutral-900 px-4 shadow-sm sm:gap-x-6 sm:px-6 lg:px-8">
    <button type="button" class="-m-2.5 p-2.5 text-gray-700 lg:hidden" @click="siteStore.sidebarIsOpen = true">
      <span class="sr-only">Open sidebar</span>
      <Icon name="uil:bars" class="h-6 w-6" aria-hidden="true" />
    </button>

    <!-- Separator -->
    <div class="h-6 w-px bg-gray-900/10 lg:hidden" aria-hidden="true" />

    <div class="flex flex-1 gap-x-4 self-stretch lg:gap-x-6">
      <form class="relative flex flex-1" action="#" method="GET">
        <label for="search-field" class="sr-only">Search</label>
        <Icon name="uil:search" class="pointer-events-none absolute inset-y-0 left-0 h-full w-5 text-gray-400" aria-hidden="true" />
        <input id="search-field" class="block h-full w-full border-0 py-0 pl-8 pr-0 bg-white dark:bg-neutral-900 text-gray-900 dark:text-neutral-200 placeholder:text-gray-400 dark:placeholder:text-neutral-400 focus:ring-0 sm:text-sm" placeholder="Search..." type="search" name="search" />
      </form>
      <div class="flex items-center gap-x-4 lg:gap-x-6">
        <!-- Site Theme Switcher -->
        <HeadlessMenu as="div" class="relative inline-block mr-4">
          <HeadlessMenuButton class="rounded focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-violet-500">
            <span class="sr-only">Site Theme</span>
            <ColorScheme placeholder="..." tag="span">
              <Icon v-if="$colorMode.value === 'dark'" name="solar:moon-bold-duotone" class="text-gray-500 dark:text-neutral-400 hover:text-violet-400 dark:hover:text-violet-400" size="1.25em" aria-hidden="true" />
              <Icon v-else name="solar:sun-2-line-duotone" class="text-gray-500 dark:text-white hover:text-violet-400 dark:hover:text-violet-400" size="1.25em" aria-hidden="true" />
            </ColorScheme>
          </HeadlessMenuButton>

          <transition enter-active-class="transition ease-out duration-100" enter-from-class="transform opacity-0 scale-95" enter-to-class="transform opacity-100 scale-100" leave-active-class="transition ease-in duration-75" leave-from-class="transform opacity-100 scale-100" leave-to-class="transform opacity-0 scale-95">
            <HeadlessMenuItems class="absolute right-0 z-10 mt-2 w-40 origin-top-right rounded-md bg-white dark:bg-neutral-800/90 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
              <div class="py-1">
                <HeadlessMenuItem v-slot="{ active }">
                  <a @click="$colorMode.preference = 'dark'" :class="[active ? 'text-violet-500 dark:text-violet-300 bg-violet-50 dark:bg-violet-500/5' : 'text-gray-700 dark:text-gray-100', 'flex items-center px-4 py-2 text-sm cursor-pointer']">
                    <Icon name="solar:moon-bold-duotone" class="mr-3" />
                    Dark
                  </a>
                </HeadlessMenuItem>
                <HeadlessMenuItem v-slot="{ active }">
                  <a @click="$colorMode.preference = 'light'" :class="[active ? 'text-violet-500 dark:text-violet-300 bg-violet-50 dark:bg-violet-500/5' : 'text-gray-700 dark:text-gray-100', 'flex items-center px-4 py-2 text-sm cursor-pointer']">
                    <Icon name="solar:sun-2-line-duotone" class="mr-3" />
                    Light
                  </a>
                </HeadlessMenuItem>
                <HeadlessMenuItem v-slot="{ active }">
                  <a @click="$colorMode.preference = 'system'" :class="[active ? 'text-violet-500 dark:text-violet-300 bg-violet-50 dark:bg-violet-500/5' : 'text-gray-700 dark:text-gray-100', 'flex items-center px-4 py-2 text-sm cursor-pointer']">
                    <Icon name="solar:laptop-line-duotone" class="mr-3" />
                    System
                  </a>
                </HeadlessMenuItem>
              </div>
            </HeadlessMenuItems>
          </transition>
        </HeadlessMenu>

        <!-- View Notifications -->
        <button type="button" class="-m-2.5 mr-2 text-gray-400 dark:text-neutral-400 hover:text-gray-500 dark:hover:text-violet-400">
          <span class="sr-only">View notifications</span>
          <Icon name="solar:bell-bold-duotone" size="1.25em" aria-hidden="true" />
        </button>

        <!-- Separator -->
        <div class="hidden lg:block lg:h-6 lg:w-px lg:bg-gray-900/10 dark:lg:bg-white/20" aria-hidden="true" />

        <!-- Profile dropdown -->
        <HeadlessMenu as="div" class="relative">
          <HeadlessMenuButton class="-m-1.5 flex items-center p-1.5">
            <span class="sr-only">Open user menu</span>
            <img class="h-8 w-8 rounded-full bg-gray-50" src="https://i.pravatar.cc/150?img=5" alt="" />
            <span class="hidden lg:flex lg:items-center">
              <span class="ml-4 text-sm font-semibold leading-6 text-gray-900 dark:text-neutral-300" aria-hidden="true">Ada Lovelace</span>
              <Icon name="uil:angle-down" class="ml-2 h-5 w-5 text-gray-400 dark:text-neutral-400" aria-hidden="true" />
            </span>
          </HeadlessMenuButton>
          <transition enter-active-class="transition ease-out duration-100" enter-from-class="transform opacity-0 scale-95" enter-to-class="transform opacity-100 scale-100" leave-active-class="transition ease-in duration-75" leave-from-class="transform opacity-100 scale-100" leave-to-class="transform opacity-0 scale-95">
            <HeadlessMenuItems class="absolute right-0 z-10 mt-2.5 w-32 origin-top-right rounded-md bg-white py-2 shadow-lg ring-1 ring-gray-900/5 focus:outline-none">
              <HeadlessMenuItem v-for="item in userNavigation" :key="item.name" v-slot="{ active }">
                <a :href="item.href" :class="[active ? 'bg-gray-50' : '', 'block px-3 py-1 text-sm leading-6 text-gray-900']">{{ item.name }}</a>
              </HeadlessMenuItem>
            </HeadlessMenuItems>
          </transition>
        </HeadlessMenu>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useSiteStore } from '@/stores/site'

// STORES

const siteStore = useSiteStore()

// DATA

const userNavigation = [
  { name: 'Your profile', href: '#' },
  { name: 'Sign out', href: '#' },
]
</script>