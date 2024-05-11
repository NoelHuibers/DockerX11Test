Use X11 Forwarding for seeing the GUI.

You need to install an X11 Viewer for this:

Windows: VcXsrv
macOS: XQuartz

Linux should have an X Server installed by default.

docker build --build-arg {OPENAI_API_KEY} -t attentive-support-robot .

X11 Forwarding: docker run -it -e DISPLAY={IP-Address}:0.0 -v /tmp/.X11-unix:/tmp/.X11-unix attentive-support-robot

python3 -i src/tool_agent.py
