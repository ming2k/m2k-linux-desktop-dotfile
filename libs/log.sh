log() {
  local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
  local level=""
  local message=""

  if [ $# -eq 1 ]; then
    level="\e[32mINFO\e[0m"
    message="$1"
  elif [ $# -eq 2 ]; then
    case "$1" in
      error)
        level="\e[31mERROR\e[0m"  # RED
        message="$2"
        ;;
      warn)
        level="\e[33mWARN\e[0m"  # YELLOW
        message="$2"
        ;;
      info)
        level="\e[32mINFO\e[0m"  # GREEN
        message="$2"
        ;;
      *)
        echo "Invalid log level: $1"
        return
        ;;
    esac
  else
    echo -e "[$timestamp] [\e[33mWARN\e[0m] Invalid number of arguments"
    return
  fi

  echo -e "[$timestamp] [$level] $message"
}