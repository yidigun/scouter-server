#!/bin/sh

# default Locale and Timezone
LANG=${LANG:-ko_KR.UTF-8}
TZ=${TZ:-Asia/Seoul}
JAVA_HOME=${JAVA_HOME:-/opt/oracle/java}
export LANG TZ JAVA_HOME

if [ -z "$CHARSET" ]; then
  CHARSET=`echo $LANG | sed -e 's/^.+\.//'`
  if [ -z "${CHARSET}" ]; then
    CHARSET=UTF-8
  elif locale -m $CHARSET 2>/dev/null | fgrep -vq $CHARSET; then
    CHARSET=UTF-8
  fi
fi

# Directories
APPROOT=${APPROOT:-/webapp}
SCOUTER_HOME=$APPROOT/scouter/server
LOGDIR=${LOGDIR:-${APPROOT}/logs}
TMPDIR=${TMPDIR:-/tmp}
export TMPDIR

# Application
BOOTAPP=${BOOTAPP:-${APPROOT}/application.jar}

# Java Options
#JAVA_BIN=${JAVA_HOME}/bin/java
JAVA_BIN="${JAVA_HOME}/bin/java"
JVM_OPT="-Xms512m \
         -Xmx4096m"
JAVA_OPT="-Dfile.encoding=${CHARSET} \
          -Djava.io.tmpdir=${TMPDIR}"

cmd=$1; shift
case $cmd in
  start)
    cd $SCOUTER_HOME
    exec $JAVA_BIN \
      $JVM_OPT \
      $JAVA_OPT \
      -classpath $SCOUTER_HOME/scouter-server-boot.jar \
      scouter.boot.Boot \
      $SCOUTER_HOME/lib \
      "$@"
    ;;

  console)
    exec /bin/sh $0 start console
    ;;

  *)
    echo usage: "$0 { start | console }"
    ;;
esac
